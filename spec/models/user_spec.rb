require 'spec_helper'

describe User do
  before(:each) do
    @attr = { 

    }
  end
  
  describe "relations" do
    it{should belong_to(:organization)}
  
    it{should have_many(:permissions)}
    it{should have_many(:twitter_accounts)}
    it{should have_many(:facebook_accounts)}
    it{should have_many(:wordpress_accounts)}
    it{should have_many(:adopt_a_pet_accounts)}
    it{should have_many(:roles)}
  end

  describe "validations" do
    it{should validate_presence_of(:username)}
    it{should validate_presence_of(:organization_name)}
  end
  
  
  describe "#add_default_role owner" do
    let(:user) { Factory(:user) }
    
    it "should create default role for the org owner" do
      user.permissions.first.role_id.should eql(2)
    end
  end
  
  describe "#add_default_role user" do
    let(:user) { Factory(:user, @attr.merge(:owner => 0)) }
    
    it "should create default role for the org user" do
      user.permissions.first.role_id.should eql(3)
    end
  end
  
  describe "#add_to_organization" do
    let(:user) { Factory(:user) }
    
    it "should add user to an organization" do
      user.organization_id.should_not be_nil
    end
  end
  
  describe 'protected attributes' do
    let(:user) { Factory(:user) }
    
    it 'should deny mass-assignment to the organization_id' do
      user.update_attributes(:organization_id =>  10000)
      user.organization_id.should_not == 10000
    end
    
    it 'should deny mass-assignment to the id' do
      user.update_attributes(:id =>  100000)
      user.id.should_not == 100000
    end
    
    it 'should deny mass-assignment to the encrypted password' do
      user.update_attributes(:encrypted_password =>  "test")
      user.encrypted_password.should_not == "test"
    end
    
    it 'should deny mass-assignment to the reset_password_token' do
      user.update_attributes(:reset_password_token =>  "test")
      user.reset_password_token.should_not == "test"
    end
    
    it 'should deny mass-assignment to the confirmation_token' do
      user.update_attributes(:confirmation_token =>  "test")
      user.confirmation_token.should_not == "test"
    end
  end

  describe 'permissions and roles' do
    it "should have 2 hives" do
      @user = Factory(:user)
      @user.roles << Factory(:role)
      assert_equal 1, @user.roles.length
    end

    it "should have 2 bees" do
      @user = Factory(:user)
      @permission = Factory(:permission)
      #puts @permission
      assert_equal 1, @user.permissions.length
    end
  end

  
end