require 'spec_helper'

describe VolunteerContact do
  before(:each) do
    @attr = { 

    }
  end
  
  describe 'relations' do
    it{should belong_to(:organization)}
  end

  describe 'validations' do
    it{should validate_presence_of(:first_name)}
    it{should validate_presence_of(:last_name)}
    it{should validate_presence_of(:address)}
    it{should validate_presence_of(:organization_id)}
  end
  
  describe '#modify_phone_number' do
    let(:volunteer_contact) { FactoryGirl.create(:volunteer_contact, @attr.merge(phone: '123-456-7890')) }
    
    it 'should strip characters from the phone number' do
      expect(volunteer_contact.phone).to eq '1234567890'
    end
  end
  
  describe '#formatted_phone' do
    let(:volunteer_contact) { FactoryGirl.create(:volunteer_contact) }
    
    it 'should format phone number' do
      expect(volunteer_contact.formatted_phone).to eq '555-555-5555'
    end
    
    it 'should return empty string if nil' do
      volunteer_contact.phone = nil
      expect(volunteer_contact.formatted_phone).to eq ''
    end
  end
  
  describe '#formatted_application_date' do
    let(:volunteer_contact) { FactoryGirl.create(:volunteer_contact, @attr.merge(application_date: '2001-10-20 00:50:22')) }
    
    it 'should format application date' do
      application_date = Time.parse('2001-10-20 00:50:22').strftime('%a, %b %e at %l:%M')
      expect(volunteer_contact.formatted_application_date).to eq application_date
    end
    
    it 'should return empty string if nil' do
      volunteer_contact.application_date = nil
      expect(volunteer_contact.formatted_application_date).to eq ''
    end
  end

  describe 'comma' do
    it 'should return a csv for the object' do
      volunteer_contact = FactoryGirl.build(:volunteer_contact)
      expect(volunteer_contact.to_comma).to_not be_blank
    end
  end   
end
