Feature: Delete Animals
  As a user of the website
  I want to delete an animal

		Scenario: Delete animal
			Given I am logged in
			When I look at the list of animals
			And I click delete
			Then I should not see the animals name
