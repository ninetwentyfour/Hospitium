Feature: List Relinquishment Contacts
  As a user of the website
  I want to see a list of relinquishment contacts in my organization
  so I manage them

		Scenario: Viewing relinquishment contacts
			Given I am logged in
			When I look at the list of relinquishment contacts
			Then I should see the relinquishment contacts name
