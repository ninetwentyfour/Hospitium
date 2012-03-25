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
    let(:relinquishment_contact) { Factory(:relinquishment_contact) }
    
    it "generates a uuid on creation" do
      relinquishment_contact.uuid.should_not be_nil
    end
  end
  
  describe "#modify_phone_number" do
    let(:relinquishment_contact) { Factory(:relinquishment_contact, @attr.merge(:phone => "123-456-7890")) }
    
    it "should strip characters from the phone number" do
      relinquishment_contact.phone.should eql("1234567890")
    end
  end
  # 
  describe "#formatted_phone" do
    let(:relinquishment_contact) { Factory(:relinquishment_contact) }
    
    it "should format phone number" do
      number = "555-555-5555"
      relinquishment_contact.formatted_phone.should eql(number)
    end
    
    it "should return empty string if nil" do
      relinquishment_contact.phone = nil
      relinquishment_contact.formatted_phone.should eql("")
    end
  end
  # 
  describe 'protected attributes' do
    let(:relinquishment_contact) { Factory(:relinquishment_contact) }
    
    it 'should deny mass-assignment to the organization_id' do
      relinquishment_contact.update_attributes(:organization_id =>  10000)
      relinquishment_contact.organization_id.should_not == 10000
    end
    
    it 'should deny mass-assignment to the uuid' do
      relinquishment_contact.update_attributes(:uuid =>  "test_uuid")
      relinquishment_contact.uuid.should_not == "test_uuid"
    end
    
    it 'should deny mass-assignment to the id' do
      relinquishment_contact.update_attributes(:id =>  100000)
      relinquishment_contact.id.should_not == 100000
    end
  end

  
end