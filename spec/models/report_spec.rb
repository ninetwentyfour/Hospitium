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

end