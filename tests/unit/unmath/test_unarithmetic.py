'''
Created on Jan 16, 2018

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

import unittest
import unmath
import unmath.unarithmetic
from unmath.unarithmetic import Unarithmetic



class TestUnarithmetic(unittest.TestCase):


	def setUp(self):
		self.unarithmetic = Unarithmetic()
		pass


	def tearDown(self):
		pass


	def testAdd(self):
		self.assertEqual(self.unarithmetic.add(3,4), 7)
		
	
	def testSubtract(self):
		self.assertEqual(self.unarithmetic.subtract(4,3), 1)	

if __name__ == "__main__":
	#import sys;sys.argv = ['', 'Test.testAdd']
	unittest.main()