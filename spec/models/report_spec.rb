require 'spec_helper'

describe Report do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe '#new_chart' do
    it 'should return a array' do
      report = Report.new_chart(@user.organization_id, 'status')
      expect(report.is_a?(Array)).to eq true
    end
  end

  describe '#item_per_day' do
    it 'should return array' do
      report = Report.item_per_day(@user.organization_id, 'animal', 7)
      expect(report.is_a?(Array)).to eq true
    end
  end

  describe '#contacts_per_day' do
    it 'should return array' do
      report = Report.contacts_per_day(@user.organization_id, 7)
      expect(report.is_a?(Array)).to eq true
    end
  end
end
