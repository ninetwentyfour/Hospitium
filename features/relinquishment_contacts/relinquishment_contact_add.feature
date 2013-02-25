Feature: Add Relinquishment Contact
  As a user of the website
  I want to add an relinquishment contact

		@javascript
		Scenario: Add relinquishment contact
			Given I am logged in
			And I wait for 5 seconds
			When I look at the list of relinquishment contacts
			And I click the add new relinquishment contact button
			And I submit the new relinquishment contact form
			Then I should see relinquishment contact was created
