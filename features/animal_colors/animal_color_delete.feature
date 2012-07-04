Feature: Delete Animal Colors
  As a user of the website
  I want to delete an animal color

		Scenario: Delete adoption contact
			Given I am logged in
			When I look at the list of animal colors
			And I click delete animal color
			Then I should not see the animal colors color
