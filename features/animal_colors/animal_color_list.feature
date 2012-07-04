Feature: List Animal Colors
  As a user of the website
  I want to see a list of animal colors in my organization
  so I manage them

		Scenario: Viewing animal colors
			Given I am logged in
			When I look at the list of animal colors
			Then I should see the animal colors color
