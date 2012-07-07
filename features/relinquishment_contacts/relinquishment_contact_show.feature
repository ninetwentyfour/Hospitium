Feature: Show Relinquishment Contact
  As a user of the website
  I want to view a single relinquishment contact
  so I can manage it

		Scenario: Show adoption contact
			Given I am logged in
			And An relinquishment contact exists
			When I view the relinquishment contact
			Then I should see the relinquishment contacts name