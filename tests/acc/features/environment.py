'''
Created on Jan 22, 2018

@author: thomasroper

	Copyright 2018 Unspecified LLC
	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at
	
	http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
'''
import threading
from utility.Exceptions import UnknownOptionException
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.common import desired_capabilities

DEFAULT_WAIT_TIME_SECONDS = 10

def get_url(context):
	userData = context.config.userdata
	env = userData.get('environment')
	if env == 'docker':
		return userData.get('docker_selenium_url')
	elif env == 'default':
		return userData.get('local_selenium_url')
	else:
		raise UnknownOptionException("Unknown environment: '%s', Please use either 'docker' or 'default'"
									 % (env))

def before_all(context):
#     context.thread = threading.Thread(target=context.server.serve_forever)
#     context.thread.start()
	capabilities = DesiredCapabilities.CHROME.copy()
	context.browser = webdriver.Remote(desired_capabilities=capabilities,
									command_executor=get_url(context))
	context.browser.implicitly_wait(DEFAULT_WAIT_TIME_SECONDS)

def after_all(context):
#     context.thread.join()
    context.browser.quit()

def before_feature(context, feature):
    pass