require 'spec_helper'

describe Admin::StatusesController do
  before :each do
    login_user

    @status = FactoryGirl.create(:status, organization_id: subject.current_user.organization_id)

    request.env['HTTP_REFERER'] = 'http://test.host'
  end

  describe 'GET "index"' do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end

    it 'returns the proper status' do
      get 'index'
      assigns(:statuses).include?(@status).should == true
    end
  end

  describe 'GET show' do
    it 'assigns the requested status as @status' do
      get :show, params: { id: @status.to_param }
      assigns(:status).should eq(@status)
    end
  end

  describe 'GET new' do
    it 'assigns a new status as @status' do
      get :new
      assigns(:status).should be_a_new(Status)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested status as @status' do
      get :edit, params: { id: @status.to_param }
      assigns(:status).should eq(@status)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new status' do
        expect do
          post :create, params: { status: FactoryGirl.attributes_for(:status) }
        end.to change(Status, :count).by(1)
      end

      it 'assigns a newly created status as @status' do
        post :create, params: { status: FactoryGirl.attributes_for(:status) }
        assigns(:status).should be_a(Status)
        assigns(:status).should be_persisted
      end

      it 'redirects to the created status' do
        post :create, params: { status: FactoryGirl.attributes_for(:status) }
        response.should redirect_to 'http://test.host'
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'assigns the requested status as @status' do
        put :update, params: { id: @status, status: FactoryGirl.attributes_for(:status) }
        assigns(:status).should eq(@status)
      end

      it 'changes @status attributes' do
        put :update, params: { id: @status.to_param, status: { 'status' => 'Edit' } }
        @status.reload
        @status.status.should eq('Edit')
      end

      it 'redirects to the status' do
        put :update, params: { id: @status, status: FactoryGirl.attributes_for(:status) }
        response.should redirect_to(admin_status_path(@status))
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested status' do
      expect do
        delete :destroy, params: { id: @status.to_param }
      end.to change(Status, :count).by(-1)
    end

    it 'redirects to the statuss list' do
      delete :destroy, params: { id: @status.to_param }
      response.should redirect_to admin_statuses_path
    end
  end
end
