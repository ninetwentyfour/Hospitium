Feature: Add Animal Color
  As a user of the website
  I want to add an animal color

		@javascript
		Scenario: Add animal color
			Given I am logged in
			When I look at the list of animal colors
			And I click the add new animal color button
			And I submit the new animal color form
			Then I should see animal color was created
