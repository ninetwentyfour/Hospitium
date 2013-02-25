def create_animal_color
  @attr = { }
  @animal_color = FactoryGirl.create(:animal_color, @attr.merge(:color => "Neon Pink", :organization => Organization.first))
end

When /^I look at the list of animal colors$/ do
  create_animal_color
  visit '/admin/animal_colors'
end

Then /^I should see the animal colors color$/ do
  page.should have_content @animal_color[:color]
end

And /^I click the add new animal color button$/ do
  click_link "Add New Animal Color"
end

And /^I submit the new animal color form$/ do
  fill_in "animal_color_color", :with => "Neon Pink"
  find_button("Add Animal Color").trigger('click')
end

Then /^I should see animal color was created$/ do
  page.should have_content "Animal Color was successfully created."
end

And /^An animal color exists$/ do
  create_animal_color
end

When /^I view the animal color$/ do
  visit "/admin/animal_colors/#{@animal_color.id}"
end

When /^I click the animal colors color$/ do
  find('.best_in_place', :text => 'Neon Pink').click
end

Then /^I edit the animal colors color$/ do
  fill_in "color", :with => "newname"
  find('.nav-tabs', :text => 'Animals').click
end

Then /^the animal colors color should change$/ do
  page.should have_content "newname"
end

And /^I click delete animal color$/ do
  animal_color = AnimalColor.find_by_color(@animal_color[:color])
  animal_color.should be
  Capybara.current_session.driver.header 'Referer', page.driver.request.env["HTTP_REFERER"]
  Capybara.current_session.driver.delete admin_animal_color_path(animal_color.id)
end

Then /^I should not see the animal colors color$/ do
  page.should_not have_content @animal_color[:color]
end