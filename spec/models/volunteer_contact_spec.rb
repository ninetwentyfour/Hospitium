require 'spec_helper'

describe VolunteerContact do
  before(:each) do
    @attr = { 

    }
  end
  
  describe "relations" do
    it{should belong_to(:organization)}
  end

  describe "validations" do
    it{should validate_presence_of(:first_name)}
    it{should validate_presence_of(:last_name)}
    it{should validate_presence_of(:address)}
    it{should validate_presence_of(:organization_id)}
  end
  
  
  describe "#create_uuid" do
    let(:volunteer_contact) { FactoryGirl.create(:volunteer_contact) }
    
    it "generates a uuid on creation" do
      volunteer_contact.uuid.should_not be_nil
    end
  end
  
  describe "#modify_phone_number" do
    let(:volunteer_contact) { FactoryGirl.create(:volunteer_contact, @attr.merge(:phone => "123-456-7890")) }
    
    it "should strip characters from the phone number" do
      volunteer_contact.phone.should eql("1234567890")
    end
  end
  
  describe "#formatted_phone" do
    let(:volunteer_contact) { FactoryGirl.create(:volunteer_contact) }
    
    it "should format phone number" do
      number = "555-555-5555"
      volunteer_contact.formatted_phone.should eql(number)
    end
    
    it "should return empty string if nil" do
      volunteer_contact.phone = nil
      volunteer_contact.formatted_phone.should eql("")
    end
  end
  
  describe "#formatted_application_date" do
    let(:volunteer_contact) { FactoryGirl.create(:volunteer_contact, @attr.merge(:application_date => "2001-10-20 00:50:22")) }
    
    it "should format application date" do
      application_date = Time.parse("2001-10-20 00:50:22").strftime("%a, %b %e at %l:%M")
      volunteer_contact.formatted_application_date.should eql(application_date)
    end
    
    it "should return empty string if nil" do
      volunteer_contact.application_date = nil
      volunteer_contact.formatted_application_date.should eql("")
    end
  end  
  
  describe 'protected attributes' do
    let(:volunteer_contact) { FactoryGirl.create(:volunteer_contact) }
    
    it 'should deny mass-assignment to the organization_id' do
      volunteer_contact.update_attributes(:organization_id =>  10000)
      volunteer_contact.organization_id.should_not == 10000
    end
    
    it 'should deny mass-assignment to the uuid' do
      volunteer_contact.update_attributes(:uuid =>  "test_uuid")
      volunteer_contact.uuid.should_not == "test_uuid"
    end
    
    it 'should deny mass-assignment to the id' do
      volunteer_contact.update_attributes(:id =>  100000)
      volunteer_contact.id.should_not == 100000
    end
  end

  describe "comma" do
    it "should return a csv for the object" do
      @volunteer_contact = FactoryGirl.build(:volunteer_contact)
      @volunteer_contact.to_comma.should_not be_blank
    end
  end   
end