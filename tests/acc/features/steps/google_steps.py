'''
Created on Jan 15, 2018

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
from behave import * 
from capybara.dsl import *
from selenium.webdriver.common.keys import Keys

@when(u'I fill in the search field with "{value}"')
def step_impl(context, value):
    fill_in("lst-ib", value=value + Keys.ENTER)

@then(u'I should see "{result}" as one of the first results')
def step_impl(context, result):
    assert has_link("Unspecified LLC")
