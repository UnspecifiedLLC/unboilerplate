IMAGE:=unboilerplate-project
REPO:=us.gcr.io/unspec-utility
QNAME:=$(REPO)/$(IMAGE)
TAG?=DEV
BRANCH?=LOCAL
BUILD_NUMBER?=0
SELENIUM_URL=http://standalone-chrome-container:4444/wd/hub

define ANNOUNCE_BODY
	Hello $(USER) 
	image built as: $(QNAME):$(TAG)
endef
define EXTENDED_ANNOUNCE_BODY
	image tagged as: '$(QNAME):$(BRANCH)' 
	image tagged as: '$(QNAME):travis-$(BUILD_NUMBER)' 
endef
export ANNOUNCE_BODY
export EXTENDED_ANNOUNCE_BODY

.PHONY: list
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs

hello:
	@echo "$$ANNOUNCE_BODY"
ifdef TRAVIS
	@echo "$$EXTENDED_ANNOUNCE_BODY"
endif		

build-image: 
	docker build -t $(QNAME):$(TAG) -f tests/Dockerfile .
	
tag-image:  
	docker tag $(QNAME):$(TAG) $(QNAME):$(BRANCH)
ifdef TRAVIS	
	docker tag $(QNAME):$(TAG) $(QNAME):travis-$(BUILD_NUMBER)
endif	
ifeq (master, $(BRANCH))
	docker tag $(QNAME):$(TAG) $(QNAME):latest
endif
	
publish-image: 
ifdef TRAVIS
	docker push $(QNAME)
else ifdef FORCE
	docker push $(QNAME)
else
	@echo "WARNING! \n \
	\tThe publish-image target is not recommended for dev use, unless you know what you're doing. \n \
	\tIf you know what you're doing, set FORCE=true in your environment and try again."
endif	

start-selenium:
	docker network create -d bridge acceptance
	docker run -itd --rm \
	--name=standalone-chrome-container \
	--network=acceptance -p 4444:4444 \
	selenium/standalone-chrome:latest 

stop-selenium: 
	docker stop standalone-chrome-container
	docker network rm acceptance

test-unit:  
	docker run -it --rm \
	--name $(IMAGE)_unit \
	--mount type=bind,source=$(realpath ./app/src),target=/app,readonly \
	--mount type=bind,source=$(realpath ./tests),target=/tests,readonly \
	$(QNAME):$(TAG) \
	-m unittest discover -s ./unit
	
test-int:
	docker run -it --rm \
	--name $(IMAGE)_integration \
	--mount type=bind,source=$(realpath ./app/src),target=/app,readonly \
	--mount type=bind,source=$(realpath ./tests),target=/tests,readonly \
	$(QNAME):$(TAG) \
	-m unittest discover -s ./int

test-acc:
	docker run -it --rm \
	--name $(IMAGE)_acceptance \
	--network=acceptance \
	--env SELENIUM_URL="http://standalone-chrome-container:4444/wd/hub" \
	--entrypoint behave \
	--mount type=bind,source=$(realpath ./app/src),target=/app,readonly \
	--mount type=bind,source=$(realpath ./tests),target=/tests,readonly \
	$(QNAME):$(TAG) \
	/tests/acc/features
	
test-all: test-unit test-int test-acc