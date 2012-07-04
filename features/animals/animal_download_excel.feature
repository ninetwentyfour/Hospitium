Feature: Download List Animals
  As a user of the website
  I want to download a list of animals in my organization
  so I manage them

		Scenario: Viewing animals
			Given I am logged in
			When I look at the list of animals
			And I click "Export"
			Then I should receive a excel file "adoption_contacts.xls"
