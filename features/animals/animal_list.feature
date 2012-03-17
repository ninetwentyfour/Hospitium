Feature: List Animals
  As a user of the website
  I want to see a list of animals in my organization
  so I manage them

		Scenario: Viewing animals
			Given I am logged in
			When I look at the list of animals
			Then I should see the animals name
