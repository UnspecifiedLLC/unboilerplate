Feature: Go to google
	To demonstrate acceptance testing a 3rd party web site
	As UNtesters
	We'll do a google search

	Scenario: Visit Google
		Given I go to "http://www.google.com/"
		When I fill in the search field with "unspecified.life"
		Then I should see "Unspecified LLC" as one of the first results
		