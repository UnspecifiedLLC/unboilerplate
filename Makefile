.PHONY: list
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs

test_unit:  
	PYTHONPATH=/code:/tests
	python3 -m unittest discover -s ./tests/unit

test_int:
	python3 -m unittest discover -s ./int

test_acc:

test: test_unit, test_int, test_acc