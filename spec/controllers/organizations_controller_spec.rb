require 'spec_helper'

#this is the public organizations controller
describe OrganizationsController do

  describe 'GET "show"' do
    it "returns http success" do
      @org = FactoryGirl.create(:organization)
      get :show, :id => @org.uuid
      response.should be_success
    end
    
    it "should find the organization by its id" do
      @org = FactoryGirl.create(:organization)
      get :show, :id => @org.uuid
      assigns(:organization).should == @org
    end

  end
end