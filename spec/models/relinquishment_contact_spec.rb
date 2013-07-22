require 'spec_helper'

describe RelinquishmentContact do
  before(:each) do
    @attr = { 

    }
  end
  
  describe "relations" do
    it{should belong_to(:organization)}
  
    it{should have_many(:animals)}
  end

  describe "validations" do
    it{should validate_presence_of(:first_name)}
    it{should validate_presence_of(:last_name)}
    it{should validate_presence_of(:organization_id)}
  end
  
  
  describe "#create_uuid" do
    let(:relinquishment_contact) { FactoryGirl.create(:relinquishment_contact) }
    
    it "generates a uuid on creation" do
      relinquishment_contact.uuid.should_not be_nil
    end
  end
  
  describe "#modify_phone_number" do
    let(:relinquishment_contact) { FactoryGirl.create(:relinquishment_contact, @attr.merge(:phone => "123-456-7890")) }
    
    it "should strip characters from the phone number" do
      relinquishment_contact.phone.should eql("1234567890")
    end
  end
  # 
  describe "#formatted_phone" do
    let(:relinquishment_contact) { FactoryGirl.create(:relinquishment_contact) }
    
    it "should format phone number" do
      number = "555-555-5555"
      relinquishment_contact.formatted_phone.should eql(number)
    end
    
    it "should return empty string if nil" do
      relinquishment_contact.phone = nil
      relinquishment_contact.formatted_phone.should eql("")
    end
  end

  describe "comma" do
    it "should return a csv for the object" do
      @relinquishment_contact = FactoryGirl.build(:relinquishment_contact)
      @relinquishment_contact.to_comma.should_not be_blank
    end
  end   
end