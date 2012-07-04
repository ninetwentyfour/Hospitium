Feature: List Adoption Contacts
  As a user of the website
  I want to see a list of adoption contacts in my organization
  so I manage them

		Scenario: Viewing adoption contacts
			Given I am logged in
			When I look at the list of adoption contacts
			Then I should see the adoption contacts name
