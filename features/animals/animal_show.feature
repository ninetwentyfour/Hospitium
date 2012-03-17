Feature: Show Animals
  As a user of the website
  I want to view a single animal
  so I can manage it

		Scenario: Show animal
			Given I am logged in
			And An animal exists
			When I view the animal
			Then I should see the animals name
