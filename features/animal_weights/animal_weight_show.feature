Feature: Show Animal Weight
  As a user of the website
  I want to view a single animal weight
  so I can manage it

		Scenario: Show animal weight
			Given I am logged in
			And An animal weight exists
			When I view the animal weight
			Then I should see the animal weights weight
