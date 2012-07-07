Feature: List Animal Weights
  As a user of the website
  I want to see a list of animal weights in my organization
  so I manage them

		Scenario: Viewing animal weights
			Given I am logged in
			When I look at the list of animal weights
			Then I should see the animal weights weight
