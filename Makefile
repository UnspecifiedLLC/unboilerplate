.PHONY: list
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs

test_image: 
	docker build -t $(subst __colon__,:,unspec-utility/unboilerplate_dev__colon__latest) \
    		-f ./Dockerfile-dev .
    	docker tag $(subst __colon__,:,unspec-utility/unboilerplate_dev us.gcr.io/unspec-utility/unboilerplate_dev__colon__latest)

start_selenium:
	docker network create -d bridge acceptance
	docker run -itd --rm\
	--name=standalone-chrome-container \
	--network=acceptance -p 4444 \
	selenium/standalone-chrome:latest 

end_selenium: 
	docker stop standalone-chrome-container
	docker network rm acceptance

test_unit:  
	docker run -it --rm \
	--name dev_test_unit \
	--mount type=bind,source=$(realpath ./app/src),target=/app,readonly \
	--mount type=bind,source=$(realpath ./tests),target=/tests,readonly \
	$(subst __colon__,:,unspec-utility/unboilerplate_dev__colon__latest) \
	-m unittest discover -s ./unit
	
test_int:
	docker run -it --rm \
	--name dev_test_int \
	--mount type=bind,source=$(realpath ./app/src),target=/app,readonly \
	--mount type=bind,source=$(realpath ./tests),target=/tests,readonly \
	$(subst __colon__,:,unspec-utility/unboilerplate_dev__colon__latest) \
	-m unittest discover -s ./int

test_acc: start_selenium
	docker run -it --rm \
	--name dev_test_acc \
	--network=acceptance \
	--mount type=bind,source=$(realpath ./app/src),target=/app,readonly \
	--mount type=bind,source=$(realpath ./tests),target=/tests,readonly \
	$(subst __colon__,:,unspec-utility/unboilerplate_dev__colon__latest) \
	--entrypoint behave 

test_all: test_unit, test_int, test_acc