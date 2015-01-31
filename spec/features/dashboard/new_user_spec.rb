require 'spec_helper'
 
describe 'New User Dashboard' do 
  before :each do
    new_logged_in_user

    visit admin_root_path
  end
 
  it 'shows the Initial Setup instructions to the user' do
    expect(page).to have_content('Initial Setup')
    expect(page).to have_content('Before doing anything else with your new account')
  end
end
