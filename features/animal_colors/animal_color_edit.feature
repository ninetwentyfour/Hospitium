Feature: Edit Animal Colors
  As a user of the website
  I want to edit a animal color
  so I can manage it

		@javascript
		Scenario: Edit animal colors color
			Given I am logged in
			And An animal color exists
			And I wait for 5 seconds
			When I view the animal color
			When I click the animal colors color
			Then I edit the animal colors color
			Then the animal colors color should change
