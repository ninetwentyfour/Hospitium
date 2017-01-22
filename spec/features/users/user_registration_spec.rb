require 'spec_helper'

describe 'User registration' do
  let(:user_email) { 'registration_test_user@example.com' }
  let(:user_password) { 'registration_test_password' }

  before :each do
    visit new_user_registration_path

    fill_in 'user_organization_name', with: 'test org'
    fill_in 'user_username', with: 'whatevs'
    fill_in 'user_email', with: user_email
    fill_in 'user_password', with: user_password
    fill_in 'user_password_confirmation', with: user_password

    click_button 'Sign up'
  end

  it 'shows message about confirmation email' do
    expect(page).to have_content('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')
  end

  describe 'confirmation email' do
    it 'has the correct email content' do
      open_email(user_email)
      expect(current_email.subject).to eq 'Confirmation instructions'
      expect(current_email.body).to have_content 'You can confirm your account through the link below:'
      expect(current_email.body).to have_content 'Confirm my account'
    end

    context 'when clicking confirmation link in email' do
      before :each do
        open_email(user_email)
        current_email.click_link 'Confirm my account'
      end

      it 'shows confirmation message' do
        expect(page).to have_content('Your account was successfully confirmed')
      end

      it 'confirms user' do
        user = User.find_for_authentication(email: user_email)
        expect(user).to be_confirmed
      end
    end
  end
end
