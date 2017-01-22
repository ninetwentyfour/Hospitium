require 'spec_helper'

describe Shelter do
  before(:each) do
    @attr = {

    }
  end

  describe 'relations' do
    it { should belong_to(:organization) }

    it { should have_many(:animals) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:organization_id) }
  end

  describe '#modify_phone_number' do
    let(:shelter) { FactoryGirl.create(:shelter, @attr.merge(phone: '123-456-7890')) }

    it 'should strip characters from the phone number' do
      expect(shelter.phone).to eq '1234567890'
    end
  end

  describe '#formatted_phone' do
    let(:shelter) { FactoryGirl.create(:shelter) }

    it 'should format phone number' do
      expect(shelter.formatted_phone).to eq '555-555-5555'
    end

    it 'should return empty string if nil' do
      shelter.phone = nil
      expect(shelter.formatted_phone).to eq ''
    end
  end

  describe 'comma' do
    it 'should return a csv for the object' do
      shelter = FactoryGirl.build(:shelter)
      expect(shelter.to_comma).to_not be_blank
    end
  end
end
