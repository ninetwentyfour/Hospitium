Feature: Add Animals
  As a user of the website
  I want to add an animal

		@javascript
		Scenario: Add animal
			Given I am logged in
			When I look at the list of animals
			And I click the add new animal button
			And I submit the new animal form
			Then I should see animal was created
