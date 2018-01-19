# unboilerplate
Boilerplate python webapp project. License, Flask, Docker, Python unit tests, web API int tests, Cucumber / Selenium acc tests, TravisCI

# project structure
This project uses the following project structure.
   * [How to Structure Large Flask Applications](https://www.digitalocean.com/community/tutorials/how-to-structure-large-flask-applications#structuring-the-application-directory) 
   * [OrangeTux](https://github.com/OrangeTux/minimal-docker-python-setup "Minimal Docker Python Setup") 
   * [Build a RESTful Flask API - the TDD Way](https://scotch.io/tutorials/build-a-restful-api-with-flask-the-tdd-way "title") 

```
~/unboilerplate				# project root
    |-- docker-compose.yml	# compose file to deploy all instances of all components (nginx, n app instances, component1, component2) for a full deploy. 
    |-- LICENSE
    |-- README.md
    |-- app
	    |-- Dockerfile	
    		|-- uwsgi.ini	
    		|-- requirements.txt   
    		|-- src					# the 'unboilerplate' application	
	    		|-- instance
	    			|-- config.py		# may be a package. manages configuration (e.g., ENV) for different runtime profiles
	    			|-- __init__.py 		# create() instantiates the Flask app instance, using config / IoC framework
    			|-- module1
    			|-- module2 
    			|-- templates
    				|-- module1
    				|-- static
    	|-- component1	#nginx, mysql, redis, etc needed for a full fledged deploy
    	|-- component2	#nginx, mysql, redis, etc needed for a full fledged deploy
    |-- /tests
		|-- docker-compose.yml	# compose file to deploy all components necessary to run all tests	
		|-- test-requirements.txt
    		|-- acc
    			|-- docker-compose.yml	# compose file to deploy all components necessary to run acceptance tests
    			|-- features
    				|-- Dockerfile		# Docker file to run all acceptance tests
    				|-- __init__.py		# define entry point to behave executable, for IDE debugging
    				|-- feature_set
    					|-- feature2.feature
    					|-- steps
    				|-- steps
    				|-- feature1.feature
    		|-- int
    			|-- docker-compose.yml	# compose file to start all containers to run int tests
	    		|-- Dockerfile			# Docker file to run all int tests
    			|-- module1				# integration tests for module1
    			|-- module2 				# integration tests for module2
    		|-- unit
    			|-- docker-compose.yml	# compose file to start all containers to run unit tests
	    		|-- Dockerfile			# Docker file to run all unit tests
    			|-- module1				# unit tests for module1
    			|-- module2 				# unit tests for module2
```


UT: 
   	from command line:
		from ~test/unit run docker-compose 
 	from IDE: 
 		use 	embedded python unit-test runner.
   
   
   
   Unit test
   		- single process
	   		- command line
	   			python -m unittest discover -s ./tests/unit
	   		- embedded in IDE
	   			right click, use runner
   			- in docker container
	 			docker run 1f75df94163d -m unittest discover -s ./unit
      	- debugger attached, breakpoints in test code or source code
   Integration tests
   		- single process
	   		- command line
	   		- embedded in IDE
   			- in docker container
   		- debugger attached, breakpoints in test code or source code
   Acceptance tests
   		- separate process from target 
   			- command line
   			- embedded in IDE
   			- in docker container
   		- requires webdriver instance
   			- embedded
   			- remote (docker container)
   			- sauce labs
   		- debugger attached, breakpoints in test code
   Deploy
   		- single process
   			- in docker container
   		- multiple process
   			- in docker containers, via docker-compose
   		- remote debugger attached, breakpoints in source code
   
   running tests in parallel: nose https://saucelabs.com/blog/running-your-selenium-tests-in-parallel-python
   
   Pipeline: 
   	Run all tests from a single script.  
# License
This project is the property of [Unspecified LLC](www.unspecified.life). It is licensed under the Apache License, version 2.0 (the "License").

This notice should appear in each file of this project:

```
   Copyright 2017 Unspecified LLC

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
```

