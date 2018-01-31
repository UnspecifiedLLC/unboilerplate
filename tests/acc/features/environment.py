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
import os
import capybara
from utility.Exceptions import UnknownOptionException
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

DEFAULT_WAIT_TIME_SECONDS = 10
SELENIUM_URL = None

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

@capybara.register_driver("selenium_remote_chrome")
def init_selenium_chrome_driver(app):
    from selenium.webdriver.chrome.options import Options

    from capybara.selenium.driver import Driver

    capybara.app = app
    capybara.default_driver = 'selenium'

    chrome_options = Options()
    if os.environ.get("HEADLESS"):
        chrome_options.add_argument("--headless")

    return Driver(app,
                  browser="remote",
                  desired_capabilities=DesiredCapabilities.CHROME,
                  command_executor=SELENIUM_URL)

def before_all(context):
    global SELENIUM_URL
    SELENIUM_URL = get_url(context)
    capybara.current_driver = "selenium_remote_chrome"
    capybara.default_max_wait_time = DEFAULT_WAIT_TIME_SECONDS
