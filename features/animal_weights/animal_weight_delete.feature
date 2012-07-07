Feature: Delete Animal Weights
  As a user of the website
  I want to delete an animal weight

		Scenario: Delete animal weight
			Given I am logged in
			When I look at the list of animal weights
			And I click delete animal weight
			Then I should not see the animal weights weight