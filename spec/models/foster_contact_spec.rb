require 'spec_helper'

describe FosterContact do
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
    it{should validate_presence_of(:address)}
    it{should validate_presence_of(:organization_id)}
  end
  
  describe "#modify_phone_number" do
    let(:foster_contact) { FactoryGirl.create(:foster_contact, @attr.merge(:phone => "123-456-7890")) }
    
    it "should strip characters from the phone number" do
      foster_contact.phone.should eql("1234567890")
    end
  end
  
  describe "#formatted_phone" do
    let(:foster_contact) { FactoryGirl.create(:foster_contact) }
    
    it "should format phone number" do
      number = "555-555-5555"
      foster_contact.formatted_phone.should eql(number)
    end
    
    it "should return empty string if nil" do
      foster_contact.phone = nil
      foster_contact.formatted_phone.should eql("")
    end
  end

  describe "comma" do
    it "should return a csv for the object" do
      @foster_contact = FactoryGirl.build(:foster_contact)
      @foster_contact.to_comma.should_not be_blank
    end
  end
  
end