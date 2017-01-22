require 'spec_helper'

describe VetContact do
  before(:each) do
    @attr = {

    }
  end

  describe 'relations' do
    it { should belong_to(:organization) }
  end

  describe 'validations' do
    it { should validate_presence_of(:clinic_name) }
  end

  describe '#modify_phone_number' do
    let(:vet_contact) { FactoryGirl.create(:vet_contact, @attr.merge(phone: '123-456-7890')) }

    it 'should strip characters from the phone number' do
      expect(vet_contact.phone).to eq '1234567890'
    end
  end

  describe '#formatted_phone' do
    let(:vet_contact) { FactoryGirl.create(:vet_contact) }

    it 'should format phone number' do
      expect(vet_contact.formatted_phone).to eq '555-555-5555'
    end

    it 'should return empty string if nil' do
      vet_contact.phone = nil
      expect(vet_contact.formatted_phone).to eq ''
    end
  end

  describe 'comma' do
    it 'should return a csv for the object' do
      vet_contact = FactoryGirl.build(:vet_contact)
      expect(vet_contact.to_comma).to_not be_blank
    end
  end
end
