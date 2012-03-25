Feature: Show Public Animals
  As a visitor to the website
  I want to view a single animal for adoption
  so I can adopt it

		Scenario: Show public animal
			Given A public animal exists
			And I view the public animal
			Then I should see the public animals name
