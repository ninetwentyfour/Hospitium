Feature: Show Adoption Contact
  As a user of the website
  I want to view a single adoption contact
  so I can manage it

		Scenario: Show adoption contact
			Given I am logged in
			And An adoption contact exists
			When I view the adoption contact
			Then I should see the adoption contacts name