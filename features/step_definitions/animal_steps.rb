def create_public_animal
  @attr = { }
  @animal = FactoryGirl.create(:animal, @attr.merge(:public => 1, :name => "Public Animal Name"))
end

def create_animal
  @attr = { }
  @animal = FactoryGirl.create(:animal, @attr.merge(:name => "Animal Name", :organization => Organization.first))
end


Given /^I look at the list of public animals$/ do
  create_public_animal
  visit '/animals'
end

Given /^A public animal exists$/ do
  create_public_animal
end

And /^I view the public animal$/ do
  visit '/animals/'+@animal.uuid
end

Then /^I should see the public animals name$/ do
  create_public_animal
  page.should have_content @animal[:name]
end



When /^I look at the list of animals$/ do
  create_animal
  visit '/admin/animals'
end

Then /^I should see the animals name$/ do
  create_animal
  page.should have_content @animal[:name]
end

And /^An animal exists$/ do
  create_animal
end

When /^I view the animal$/ do
  visit '/admin/animals/'+@animal.id.to_s
end

When /^I click the animal name$/ do
  find('.best_in_place', :text => 'Animal Name').click
end

Then /^I edit the animal name$/ do
  fill_in "name", :with => "newname"
  find('.nav-tabs', :text => 'Overview').click
end

Then /^the animal name should change$/ do
  page.should have_content "newname"
end

And /^I click the add new animal button$/ do
  @species = FactoryGirl.create(:species, @attr.merge(:name => "test species", :organization => Organization.first))
  @animal_color = FactoryGirl.create(:animal_color, @attr.merge(:color => "yellow", :organization => Organization.first))
  click_link "Add New Animal"
end

When /^I click Cage Card$/ do
  click_link "Cage Card"
end

And /^I submit the new animal form$/ do
  fill_in "Name", :with => "example animal name"
  fill_in "Date of intake", :with => "2011-10-20 00:50:22"
  click_button "Add Animal"
end

Then /^I should see animal was created$/ do
  page.should have_content "Animal was successfully created."
end

And /^I click delete$/ do
  animal = Animal.find_by_name(@animal[:name])
  animal.should be
  Capybara.current_session.driver.header 'Referer', page.driver.request.env["HTTP_REFERER"]
  Capybara.current_session.driver.delete admin_animal_path(animal.id)
end

Then /^I should not see the animals name$/ do
  page.should_not have_content @animal[:name]
end

And /^I click duplicate$/ do
  find('.duplicate-button').click
end

Then /^I should see the same animal twice$/ do
  page.should have_content "Successfully duplicated."
  page.should have_xpath('//a', :text => @animal[:name], :count => 2)
end