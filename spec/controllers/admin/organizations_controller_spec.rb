require 'spec_helper'

describe Admin::OrganizationsController do
  before :each do
    login_user

    @organization = FactoryGirl.create(:organization)
    subject.current_user.organization_id = @organization.id
    subject.current_user.save!
  end

  describe 'GET "index"' do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end

    it 'returns the proper organization' do
      get 'index'
      assigns(:organizations).include?(@organization).should == true
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'assigns the requested organization as @organization' do
        request.env['HTTP_REFERER'] = 'localhost'
        put :update, params: { id: @organization, organization: FactoryGirl.attributes_for(:organization) }
        assigns(:organization).should eq(@organization)
      end

      it 'changes @organization attributes' do
        request.env['HTTP_REFERER'] = 'localhost'
        put :update, params: { id: @organization.to_param, organization: { 'name' => 'Edit' } }
        @organization.reload
        @organization.name.should eq('Edit')
      end
    end
  end
end
