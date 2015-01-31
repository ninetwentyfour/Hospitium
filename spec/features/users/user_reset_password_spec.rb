require 'spec_helper'
 
describe 'User Password Reset' do 
  before :each do
    @user = FactoryGirl.create(:user)
    @user.confirmed_at = Time.now
    @user.save

    visit new_user_password_path

    fill_in 'user_email', with: @user.email
    click_button 'Send me reset password instructions'
    @user.reload
    expect(@user.reset_password_token).to_not be_nil
  end
 
  it 'shows message about the password reset email' do
    expect(page).to have_content('You will receive an email with instructions about how to reset your password in a few minutes.')
  end
 
  describe 'password reset email' do
    it 'has the correct email content' do
      open_email(@user.email)
      expect(current_email.subject).to eq 'Reset password instructions'
      expect(current_email.body).to have_content 'Someone has requested a link to change your Hospitium password, and you can do this through the link below.'
      expect(current_email.body).to have_content 'Change my password'
    end

    context 'when clicking reset link in email' do   
      it 'lets the user set a new password' do
        open_email(@user.email)

        current_email.click_link 'Change my password'

        fill_in 'user_password', with: 'super_new_password'
        fill_in 'user_password_confirmation', with: 'super_new_password'
        click_button 'Change my password'

        expect(page).to have_content('Your password was changed successfully. You are now signed in.')

        # log out and confirm login works with new password
        visit destroy_user_session_path
        visit new_user_session_path
        fill_in 'user_login', with: @user.email
        fill_in 'user_password', with: 'super_new_password'
        click_button 'Log me in'

        expect(page).to have_content 'Signed in successfully.'
      end
    end
  end
end
