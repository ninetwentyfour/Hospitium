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
    it{should have_many(:notes)}
    it{should have_many(:roles)}
  end

  # describe "validations" do
  #   it{should validate_presence_of(:username)}
  #   it{should validate_presence_of(:organization_name)}
  # end

  describe "abilities" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.roles << FactoryGirl.create(:role)
    end
    it "should be able to manage animal" do
      ability = Ability.new(@user)
      animal = FactoryGirl.create(:animal, :organization_id => @user.organization_id)

      ability.should be_able_to(:read, animal)
      ability.should be_able_to(:create, animal)
      ability.should be_able_to(:update, animal)
      ability.should be_able_to(:duplicate, animal)
      ability.should be_able_to(:qr_code, animal)
      ability.should be_able_to(:cage_card, animal)
      ability.should be_able_to(:export, animal)
      ability.should be_able_to(:bulk_action, animal)
      ability.should be_able_to(:destroy, animal)
    end
  end
  
  
  describe "#add_default_role owner" do
    let(:user) { FactoryGirl.create(:user) }
    
    it "should create default role for the org owner" do
      user.permissions.first.role_id.should eql(2)
    end
  end
  
  describe "#add_default_role user" do
    let(:user) { FactoryGirl.create(:user, @attr.merge(:owner => 0)) }
    
    it "should create default role for the org user" do
      user.permissions.first.role_id.should eql(3)
    end
  end
  
  describe "#add_to_organization" do
    let(:user) { FactoryGirl.create(:user) }
    
    it "should add user to an organization" do
      user.organization_id.should_not be_nil
    end
  end

  describe 'permissions and roles' do
    it "should have 2 hives" do
      @user = FactoryGirl.create(:user)
      @user.roles << FactoryGirl.create(:role)
      assert_equal 1, @user.roles.length
    end

    it "should have 2 bees" do
      @user = FactoryGirl.create(:user)
      @permission = FactoryGirl.create(:permission)
      #puts @permission
      assert_equal 1, @user.permissions.length
    end
  end

  describe "#show_username_label_method" do
    let(:user) { FactoryGirl.create(:user) }
    
    it "should return the username value as a string" do
      user.show_username_label_method.should == "#{user.username}"
    end
  end

  describe "#role?" do
    
    it "should return true for Admin role" do
      @user = FactoryGirl.create(:user)
      @user.roles << FactoryGirl.create(:role)
      @user.role?("Admin").should == true
    end
  end

  describe "#add_to_organization" do
    
    it "should set organization if org_id nil" do
      @user = FactoryGirl.create(:user)
      @user.organization_id = nil
      @user.add_to_organization
      @user.organization_id.should_not be_nil
    end
  end

  
end