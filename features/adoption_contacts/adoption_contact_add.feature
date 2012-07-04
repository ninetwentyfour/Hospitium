Feature: Add Adoption Contact
  As a user of the website
  I want to add an adoption contact

		@javascript
		Scenario: Add adoption contact
			Given I am logged in
			When I look at the list of adoption contacts
			And I click the add new adoption contact button
			And I submit the new adoption contact form
			Then I should see adoption contact was created
