Feature: Delete Adoption Contacts
  As a user of the website
  I want to delete an adoption contact

		Scenario: Delete adoption contact
			Given I am logged in
			When I look at the list of adoption contacts
			And I click delete adoption contact
			Then I should not see the adoption contacts name
