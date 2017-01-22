require 'spec_helper'

describe Admin::AnimalColorsController do
  before :each do
    login_user

    @animal_color = FactoryGirl.create(:animal_color, organization_id: subject.current_user.organization_id)
  end

  describe 'GET "index"' do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end

    it 'returns the proper animal_color' do
      get 'index'
      assigns(:animal_colors).include?(@animal_color).should == true
    end
  end

  describe 'GET show' do
    it 'assigns the requested animal_color as @animal_color' do
      get :show, params: { id: @animal_color.to_param }
      assigns(:animal_color).should eq(@animal_color)
    end
  end

  describe 'GET new' do
    it 'assigns a new animal_color as @animal_color' do
      get :new
      assigns(:animal_color).should be_a_new(AnimalColor)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested animal_color as @animal_color' do
      get :edit, params: { id: @animal_color.to_param }
      assigns(:animal_color).should eq(@animal_color)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new animal_color' do
        expect do
          post :create, params: { animal_color: FactoryGirl.attributes_for(:animal_color) }
        end.to change(AnimalColor, :count).by(1)
      end

      it 'assigns a newly created animal_color as @animal_color' do
        post :create, params: { animal_color: FactoryGirl.attributes_for(:animal_color) }
        assigns(:animal_color).should be_a(AnimalColor)
        assigns(:animal_color).should be_persisted
      end

      it 'redirects to the created animal_color' do
        post :create, params: { animal_color: FactoryGirl.attributes_for(:animal_color) }
        response.should redirect_to(admin_animal_color_path(AnimalColor.order(created_at: :desc).first))
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'assigns the requested animal_color as @animal_color' do
        put :update, params: { id: @animal_color, animal_color: FactoryGirl.attributes_for(:animal_color) }
        assigns(:animal_color).should eq(@animal_color)
      end

      it 'changes @animal_color attributes' do
        put :update, params: { id: @animal_color.to_param, animal_color: { 'color' => 'Edit' } }
        @animal_color.reload
        @animal_color.color.should eq('Edit')
      end

      it 'redirects to the animal_color' do
        put :update, params: { id: @animal_color, animal_color: FactoryGirl.attributes_for(:animal_color) }
        response.should redirect_to(admin_animal_color_path(@animal_color))
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested animal_color' do
      expect do
        delete :destroy, params: { id: @animal_color.to_param }
      end.to change(AnimalColor, :count).by(-1)
    end

    it 'redirects to the animal_colors list' do
      delete :destroy, params: { id: @animal_color.to_param }
      response.should redirect_to(admin_animal_colors_url)
    end
  end
end
