module ControllerMacros
  # Public: logs in a customer for testing. This method mocks out the
  # :symfony devise strategy as well as the SfSession class to make
  # authentication possible in testing. It will assing an @user variable
  # to the test.
  #
  # Examples
  #
  #   # to allow all tests to require a login
  #   before :each do
  #     login_user
  #   end
  #
  #   # to use in a single test
  #   it 'should look like this' do
  #     login_user
  #   end
  #
  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    @user.roles << FactoryGirl.create(:role)
    @user.confirm!
    sign_in @user
  end

  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    @user.roles << FactoryGirl.create(:role, :name => "SuperAdmin")
    @user.confirm!
    sign_in @user
  end

end