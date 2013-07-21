require 'spec_helper'

describe Organization do
  before(:each) do
    @attr = { 

    }
  end
  
  describe "relations" do
  
    it{should have_many(:adoption_contacts)}
    it{should have_many(:animals)}
    it{should have_many(:animal_colors)}
    it{should have_many(:animal_weights)}
    it{should have_many(:facebook_accounts)}
    it{should have_many(:relinquishment_contacts)}
    it{should have_many(:shelters)}
    it{should have_many(:species)}
    it{should have_many(:statuses)}
    it{should have_many(:twitter_accounts)}
    it{should have_many(:vet_contacts)}
    it{should have_many(:volunteer_contacts)}
    it{should have_many(:wordpress_accounts)}
    it{should have_many(:users)}
    
  end
  
  
  describe "#create_uuid" do
    let(:organization) { FactoryGirl.create(:organization) }
    
    it "generates a uuid on creation" do
      organization.uuid.should_not be_nil
    end
  end
  
  describe "#add_default_status" do
    let(:organization) { FactoryGirl.create(:organization) }
    
    it "should create default statuses" do
      organization.statuses.size.should eql(7)
    end
  end
  
  describe "#add_default_animal_colors" do
    let(:organization) { FactoryGirl.create(:organization) }
    
    it "should create default animal colors" do
      organization.animal_colors.size.should eql(4)
    end
  end
  
  describe "#add_default_species" do
    let(:organization) { FactoryGirl.create(:organization) }
    
    it "should create default species" do
      organization.species.size.should eql(8)
    end
  end

  describe "#modify_phone_number" do
    let(:organization) { FactoryGirl.create(:organization) }
    
    it "should strip characters from the phone number" do
      organization.update_attributes(:phone_number => "123-456-7890")
      organization.phone_number.should eql("1234567890")
    end
  end
  
  describe "#formatted_phone" do
    let(:organization) { FactoryGirl.create(:organization) }
    
    it "should format phone number" do
      organization.update_attributes(:phone_number => "123-456-7890")
      organization.formatted_phone.should eql("123-456-7890")
    end
    
    it "should return empty string if nil" do
      organization.phone_number = nil
      organization.formatted_phone.should eql("")
    end
  end
  
  describe 'has_info?' do    
    it 'should return true for orgs with an email' do
      @org = FactoryGirl.create(:organization, :email => "test@example.com")
      @org.has_info?.should == true
    end
    
    it 'should return true for orgs with an phone' do
      @org = FactoryGirl.create(:organization, :phone_number => "5555555555")
      @org.has_info?.should == true
    end
    
    it 'should return true for orgs with an website' do
      @org = FactoryGirl.create(:organization, :website => "example.com")
      @org.has_info?.should == true
    end
    
    it 'should return false for orgs with no info' do
      @org = FactoryGirl.create(:organization)
      @org.has_info?.should == false
    end
  end

  
end