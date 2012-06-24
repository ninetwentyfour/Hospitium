require 'spec_helper'

describe VetContact do
  before(:each) do
    @attr = { 

    }
  end
  
  describe "relations" do
    it{should belong_to(:organization)}
  end

  describe "validations" do
    it{should validate_presence_of(:clinic_name)}
  end
  
  
  describe "#create_uuid" do
    let(:vet_contact) { FactoryGirl.create(:vet_contact) }
    
    it "generates a uuid on creation" do
      vet_contact.uuid.should_not be_nil
    end
  end
  
  describe "#modify_phone_number" do
    let(:vet_contact) { FactoryGirl.create(:vet_contact, @attr.merge(:phone => "123-456-7890")) }
    
    it "should strip characters from the phone number" do
      vet_contact.phone.should eql("1234567890")
    end
  end
  
  describe "#formatted_phone" do
    let(:vet_contact) { FactoryGirl.create(:vet_contact) }
    
    it "should format phone number" do
      number = "555-555-5555"
      vet_contact.formatted_phone.should eql(number)
    end
    
    it "should return empty string if nil" do
      vet_contact.phone = nil
      vet_contact.formatted_phone.should eql("")
    end
  end
  
  describe 'protected attributes' do
    let(:vet_contact) { FactoryGirl.create(:vet_contact) }
    
    it 'should deny mass-assignment to the organization_id' do
      vet_contact.update_attributes(:organization_id =>  10000)
      vet_contact.organization_id.should_not == 10000
    end
    
    it 'should deny mass-assignment to the uuid' do
      vet_contact.update_attributes(:uuid =>  "test_uuid")
      vet_contact.uuid.should_not == "test_uuid"
    end
    
    it 'should deny mass-assignment to the id' do
      vet_contact.update_attributes(:id =>  100000)
      vet_contact.id.should_not == 100000
    end
  end

  
end