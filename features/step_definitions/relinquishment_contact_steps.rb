def create_relinquishment_contact
  @attr = { }
  @relinquishment_contact = FactoryGirl.create(:relinquishment_contact, @attr.merge(:first_name => "relinquishment first name", :organization => Organization.first))
end

When /^I look at the list of relinquishment contacts$/ do
  create_relinquishment_contact
  visit '/admin/relinquishment_contacts'
end

Then /^I should see the relinquishment contacts name$/ do
  page.should have_content @relinquishment_contact[:first_name]
end

And /^An relinquishment contact exists$/ do
  create_relinquishment_contact
end

When /^I view the relinquishment contact$/ do
  visit "/admin/relinquishment_contacts/#{@relinquishment_contact.id}"
end

And /^I click the add new relinquishment contact button$/ do
  click_link "Add New Relinquishment Contact"
end

And /^I submit the new relinquishment contact form$/ do
  fill_in "First name", :with => "example adoption contact name"
  fill_in "Last name", :with => "last name"
  fill_in "Address", :with => "123 Fake st"
  fill_in "Phone", :with => "555-555-5555"
  fill_in "Email", :with => "test@example.com"
  click_button "Add Relinquishment Contact"
end

Then /^I should see relinquishment contact was created$/ do
  page.should have_content "Relinquishment contact was successfully created."
end