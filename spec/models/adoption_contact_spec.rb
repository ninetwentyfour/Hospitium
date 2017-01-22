require 'spec_helper'

describe AdoptionContact do
  before(:each) do
    @attr = {

    }
  end

  describe 'relations' do
    it { should belong_to(:organization) }

    it { should have_many(:animals) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:organization_id) }
  end

  describe '#modify_phone_number' do
    let(:adoption_contact) { FactoryGirl.create(:adoption_contact, @attr.merge(phone: '123-456-7890')) }

    it 'should strip characters from the phone number' do
      expect(adoption_contact.phone).to eq '1234567890'
    end
  end

  describe '#formatted_phone' do
    let(:adoption_contact) { FactoryGirl.create(:adoption_contact) }

    it 'should format phone number' do
      expect(adoption_contact.formatted_phone).to eq '555-555-5555'
    end

    it 'should return empty string if nil' do
      adoption_contact.phone = nil
      expect(adoption_contact.formatted_phone).to eq ''
    end
  end

  describe 'comma' do
    it 'should return a csv for the object' do
      adoption_contact = FactoryGirl.build(:adoption_contact)
      expect(adoption_contact.to_comma).to_not be_blank
    end
  end
end
