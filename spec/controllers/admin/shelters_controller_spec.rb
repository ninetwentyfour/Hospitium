require 'spec_helper'

describe Admin::SheltersController do
  before :each do
    login_user

    @shelter = FactoryGirl.create(:shelter, organization_id: subject.current_user.organization_id)

    request.env['HTTP_REFERER'] = 'http://test.host'
  end

  describe 'GET "index"' do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end

    it 'returns the proper shelter' do
      get 'index'
      assigns(:shelters).include?(@shelter).should == true
    end
  end

  describe 'GET show' do
    it 'assigns the requested shelter as @shelter' do
      get :show, params: { id: @shelter.to_param }
      assigns(:shelter).should eq(@shelter)
    end
  end

  describe 'GET new' do
    it 'assigns a new shelter as @shelter' do
      get :new
      assigns(:shelter).should be_a_new(Shelter)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested shelter as @shelter' do
      get :edit, params: { id: @shelter.to_param }
      assigns(:shelter).should eq(@shelter)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new shelter' do
        expect do
          post :create, params: { shelter: FactoryGirl.attributes_for(:shelter) }
        end.to change(Shelter, :count).by(1)
      end

      it 'assigns a newly created shelter as @shelter' do
        post :create, params: { shelter: FactoryGirl.attributes_for(:shelter) }
        assigns(:shelter).should be_a(Shelter)
        assigns(:shelter).should be_persisted
      end

      it 'redirects to the created shelter' do
        post :create, params: { shelter: FactoryGirl.attributes_for(:shelter) }
        response.should redirect_to 'http://test.host'
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'assigns the requested shelter as @shelter' do
        put :update, params: { id: @shelter, shelter: FactoryGirl.attributes_for(:shelter) }
        assigns(:shelter).should eq(@shelter)
      end

      it 'changes @shelter attributes' do
        put :update, params: { id: @shelter.to_param, shelter: { 'name' => 'Edit' } }
        @shelter.reload
        @shelter.name.should eq('Edit')
      end

      it 'redirects to the shelter' do
        put :update, params: { id: @shelter, shelter: FactoryGirl.attributes_for(:shelter) }
        response.should redirect_to(admin_shelter_path(@shelter))
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested shelter' do
      expect do
        delete :destroy, params: { id: @shelter.to_param }
      end.to change(Shelter, :count).by(-1)
    end

    it 'redirects to the shelters list' do
      delete :destroy, params: { id: @shelter.to_param }
      response.should redirect_to(admin_shelters_url)
    end
  end
end
