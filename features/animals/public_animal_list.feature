Feature: Show Public Animals
  As a visitor to the website
  I want to see a list of animals for adoption
  so I can adopt one

		Scenario: Viewing public animals
			Given I look at the list of public animals
			Then I should see the public animals name
