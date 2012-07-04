def create_adoption_contact
  @attr = { }
  @adoption_contact = FactoryGirl.create(:adoption_contact, @attr.merge(:first_name => "adoption first name", :organization => Organization.first))
end

When /^I look at the list of adoption contacts$/ do
  create_adoption_contact
  visit '/admin/adoption_contacts'
end

Then /^I should see the adoption contacts name$/ do
  page.should have_content @adoption_contact[:first_name]
end

And /^An adoption contact exists$/ do
  create_adoption_contact
end

When /^I view the adoption contact$/ do
  visit "/admin/adoption_contacts/#{@adoption_contact.id}"
end

And /^I click the add new adoption contact button$/ do
  click_link "Add New Adoption Contact"
end

And /^I submit the new adoption contact form$/ do
  fill_in "First name", :with => "example adoption contact name"
  fill_in "Last name", :with => "last name"
  fill_in "Address", :with => "123 Fake st"
  fill_in "Phone", :with => "555-555-5555"
  fill_in "Email", :with => "test@example.com"
  click_button "Add Adoption Contact"
end

Then /^I should see adoption contact was created$/ do
  page.should have_content "Adoption contact was successfully created."
end

When /^I click the adoption contact first name$/ do
  find('.best_in_place', :text => 'adoption first name').click
end

Then /^I edit the adoption contact first name$/ do
  fill_in "first_name", :with => "newname"
  find('.nav-tabs', :text => 'Overview').click
end

Then /^the adoption contact first name should change$/ do
  page.should have_content "newname"
end

And /^I click delete adoption contact$/ do
  adoption_contact = AdoptionContact.find_by_first_name(@adoption_contact[:first_name])
  adoption_contact.should be
  Capybara.current_session.driver.header 'Referer', page.driver.request.env["HTTP_REFERER"]
  Capybara.current_session.driver.delete admin_adoption_contact_path(adoption_contact.id)
end

Then /^I should not see the adoption contacts name$/ do
  page.should_not have_content @adoption_contact[:first_name]
end