Feature: Download List Adoption Contacts
  As a user of the website
  I want to download a list of adoption contacts in my organization
  so I manage them

		Scenario: Viewing adoption contacts
			Given I am logged in
			When I look at the list of adoption contacts
			And I click "Export"
			Then I should receive a excel file "adoption_contacts.xls"
