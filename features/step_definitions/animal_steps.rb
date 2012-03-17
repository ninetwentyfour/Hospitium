def create_public_animal
  @attr = { }
  @animal = Factory(:animal, @attr.merge(:public => 1, :name => "Public Animal Name"))
end

def create_animal
  @attr = { }
  @animal = Factory(:animal, @attr.merge(:name => "Animal Name", :organization => Organization.first))
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