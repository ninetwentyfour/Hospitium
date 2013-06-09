require 'spec_helper'

describe Shelter do
  before(:each) do
    @attr = { 

    }
  end
  
  describe "relations" do
    it{should belong_to(:organization)}
  
    it{should have_many(:animals)}
  end

  describe "validations" do
    it{should validate_presence_of(:name)}
    it{should validate_presence_of(:organization_id)}
  end
  
  
  describe "#create_uuid" do
    let(:shelter) { FactoryGirl.create(:shelter) }
    
    it "generates a uuid on creation" do
      shelter.uuid.should_not be_nil
    end
  end
  
  describe "#modify_phone_number" do
    let(:shelter) { FactoryGirl.create(:shelter, @attr.merge(:phone => "123-456-7890")) }
    
    it "should strip characters from the phone number" do
      shelter.phone.should eql("1234567890")
    end
  end
  
  describe "#formatted_phone" do
    let(:shelter) { FactoryGirl.create(:shelter) }
    
    it "should format phone number" do
      number = "555-555-5555"
      shelter.formatted_phone.should eql(number)
    end
    
    it "should return empty string if nil" do
      shelter.phone = nil
      shelter.formatted_phone.should eql("")
    end
  end
  
  describe 'protected attributes' do
    let(:shelter) { FactoryGirl.create(:shelter) }
    
    it 'should deny mass-assignment to the organization_id' do
      shelter.update_attributes(:organization_id =>  10000)
      shelter.organization_id.should_not == 10000
    end
    
    it 'should deny mass-assignment to the uuid' do
      shelter.update_attributes(:uuid =>  "test_uuid")
      shelter.uuid.should_not == "test_uuid"
    end
    
    it 'should deny mass-assignment to the id' do
      shelter.update_attributes(:id =>  100000)
      shelter.id.should_not == 100000
    end
  end

  describe "comma" do
    it "should return a csv for the object" do
      @shelter = FactoryGirl.build(:shelter)
      @shelter.to_comma.should_not be_blank
    end
  end  
end