require 'spec_helper'

describe Report do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe "#animals_by" do
    
  	it 'should return a hash' do
      report = Report.animals_by(@user.organization_id, "status")

      report.should be_kind_of(Hash)
  	end
  end

end