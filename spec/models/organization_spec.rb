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
    let(:organization) { Factory(:organization) }
    
    it "generates a uuid on creation" do
      organization.uuid.should_not be_nil
    end
  end
  
  describe "#add_default_status" do
    let(:organization) { Factory(:organization) }
    
    it "should create default statuses" do
      organization.statuses.size.should eql(7)
    end
  end

  describe "#modify_phone_number" do
    let(:organization) { Factory(:organization) }
    
    it "should strip characters from the phone number" do
      organization.update_attributes(:phone_number => "123-456-7890")
      organization.phone_number.should eql("1234567890")
    end
  end
  
  describe "#formatted_phone" do
    let(:organization) { Factory(:organization) }
    
    it "should format phone number" do
      organization.update_attributes(:phone_number => "123-456-7890")
      organization.formatted_phone.should eql("123-456-7890")
    end
    
    it "should return empty string if nil" do
      organization.phone_number = nil
      organization.formatted_phone.should eql("")
    end
  end
  
  describe 'protected attributes' do
    let(:organization) { Factory(:organization) }
    
    it 'should deny mass-assignment to the uuid' do
      organization.update_attributes(:uuid =>  "test_uuid")
      organization.uuid.should_not == "test_uuid"
    end
    
    it 'should deny mass-assignment to the id' do
      organization.update_attributes(:id =>  100000)
      organization.id.should_not == 100000
    end
  end

  
end