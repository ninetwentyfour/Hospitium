Feature: Sign out
  To protect my account from unauthorized access
  A signed in user
  Should be able to sign out

	@javascript
	Scenario: User signs out
		Given I am logged in
		And I wait for 5 seconds
		When I sign out
		Then I should see a signed out message
		When I return to the site
		Then I should be signed out
