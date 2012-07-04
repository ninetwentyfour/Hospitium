Feature: Show Animal Color
  As a user of the website
  I want to view a single animal color
  so I can manage it

		Scenario: Show animal color
			Given I am logged in
			And An animal color exists
			When I view the animal color
			Then I should see the animal colors color
