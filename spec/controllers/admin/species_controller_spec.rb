require 'spec_helper'

describe Admin::SpeciesController do
  before :each do
    login_user

    @species = FactoryGirl.create(:species, organization_id: subject.current_user.organization_id)

    request.env['HTTP_REFERER'] = 'http://test.host'
  end

  describe 'GET "index"' do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end

    it 'returns the proper species' do
      get 'index'
      assigns(:species).include?(@species).should == true
    end
  end

  describe 'GET show' do
    it 'assigns the requested species as @species' do
      get :show, params: { id: @species.to_param }
      assigns(:species).should eq(@species)
    end
  end

  describe 'GET new' do
    it 'assigns a new species as @species' do
      get :new
      assigns(:species).should be_a_new(Species)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested species as @species' do
      get :edit, params: { id: @species.to_param }
      assigns(:species).should eq(@species)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new species' do
        expect do
          post :create, params: { species: FactoryGirl.attributes_for(:species) }
        end.to change(Species, :count).by(1)
      end

      it 'assigns a newly created species as @species' do
        post :create, params: { species: FactoryGirl.attributes_for(:species) }
        assigns(:species).should be_a(Species)
        assigns(:species).should be_persisted
      end

      it 'redirects to the created species' do
        post :create, params: { species: FactoryGirl.attributes_for(:species) }
        response.should redirect_to 'http://test.host'
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'assigns the requested species as @species' do
        put :update, params: { id: @species, species: FactoryGirl.attributes_for(:species) }
        assigns(:species).should eq(@species)
      end

      it 'changes @species attributes' do
        put :update, params: { id: @species.to_param, species: { 'name' => 'Edit' } }
        @species.reload
        @species.name.should eq('Edit')
      end

      it 'redirects to the species' do
        put :update, params: { id: @species, species: FactoryGirl.attributes_for(:species) }
        response.should redirect_to(admin_species_path(@species))
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested species' do
      expect do
        delete :destroy, params: { id: @species.to_param }
      end.to change(Species, :count).by(-1)
    end

    it 'redirects to the speciess list' do
      delete :destroy, params: { id: @species.to_param }
      response.should redirect_to 'http://test.host'
    end
  end
end
