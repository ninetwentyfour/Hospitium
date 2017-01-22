require 'spec_helper'

describe Shot do
  before(:each) do
    @attr = {

    }
  end

  describe 'relations' do
    it { should belong_to(:organization) }
    it { should belong_to(:animal) }
  end

  describe 'validations' do
    it { should validate_presence_of(:animal_id) }
    it { should validate_presence_of(:name) }
  end

  describe '#formatted_last_administered_date' do
    let(:shot) { FactoryGirl.create(:shot, @attr.merge(last_administered: '2001-10-20 00:50:22')) }

    it 'should format last administered date' do
      last_administered_date = Time.parse('2001-10-20 00:50:22').strftime('%a, %b %e at %l:%M')
      expect(shot.formatted_last_administered_date).to eq last_administered_date
    end

    it 'should return empty string if nil' do
      shot.last_administered = nil
      expect(shot.formatted_last_administered_date).to eq ''
    end
  end

  describe '#formatted_expires_date' do
    let(:shot) { FactoryGirl.create(:shot, @attr.merge(expires: '2001-10-20 00:50:22')) }

    it 'should format expires date' do
      expires_date = Time.parse('2001-10-20 00:50:22').strftime('%a, %b %e at %l:%M')
      expect(shot.formatted_expires_date).to eq expires_date
    end

    it 'should return empty string if nil' do
      shot.expires = nil
      expect(shot.formatted_expires_date).to eq ''
    end
  end

  describe 'comma' do
    it 'should return a csv for the object' do
      shot = FactoryGirl.build(:shot)
      expect(shot.to_comma).to_not be_blank
    end
  end
end
