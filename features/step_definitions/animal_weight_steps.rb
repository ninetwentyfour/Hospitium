def create_animal_weight
  @attr = { }
  @animal = FactoryGirl.create(:animal, :public => 1, :name => "Public Animal Name", :organization => Organization.first)
  @animal_weight = FactoryGirl.create(:animal_weight, @attr.merge(:animal => @animal, :organization => Organization.first))
end

When /^I look at the list of animal weights$/ do
  create_animal_weight
  visit '/admin/animal_weights'
end

Then /^I should see the animal weights weight$/ do
  page.should have_content @animal_weight[:weight]
end

And /^An animal weight exists$/ do
  create_animal_weight
end

When /^I view the animal weight$/ do
  visit "/admin/animal_weights/#{@animal_weight.id}"
end

And /^I click delete animal weight$/ do
  animal_weight = AnimalWeight.find_by_weight(@animal_weight[:weight])
  animal_weight.should be
  Capybara.current_session.driver.header 'Referer', page.driver.request.env["HTTP_REFERER"]
  Capybara.current_session.driver.delete admin_animal_weight_path(animal_weight.id)
end

Then /^I should not see the animal weights weight$/ do
  page.should_not have_content @animal_weight[:weight]
end