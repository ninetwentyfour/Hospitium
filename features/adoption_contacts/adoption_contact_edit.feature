Feature: Edit Animals
  As a user of the website
  I want to edit a adoption contact
  so I can manage it

		@javascript
		Scenario: Edit adoption contact first name
			Given I am logged in
			And An adoption contact exists
			When I view the adoption contact
			When I click the adoption contact first name
			Then I edit the adoption contact first name
			Then the adoption contact first name should change
