require 'spec_helper'

describe Report do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe "#new_chart" do
    
  	it 'should return a array' do
      report = Report.new_chart(@user.organization_id, "status")

      report.should be_kind_of(Array)
  	end
  end


  describe "#item_per_day" do
  	it 'should return array' do
      report = Report.item_per_day(@user.organization_id, "animal", 7)

      report.should be_kind_of(Array)  		
  	end
  end

  describe "#contacts_per_day" do
  	it 'should return array' do
      report = Report.contacts_per_day(@user.organization_id, 7)

      report.should be_kind_of(Array)  		
  	end
  end
end