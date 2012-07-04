Feature: Show Animals
  As a user of the website
  I want to view a cage card of a single animal
  so I can manage it

		Scenario: View Cage Card
			Given I am logged in
			And An animal exists
			When I view the animal
			And I click "Cage Card"
			Then I should see the animals name
