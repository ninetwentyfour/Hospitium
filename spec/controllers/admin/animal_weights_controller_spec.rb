require 'spec_helper'

describe Admin::AnimalWeightsController do
  before :each do
    login_user

    @animal_weight = FactoryGirl.create(:animal_weight, organization_id: subject.current_user.organization_id)

    request.env['HTTP_REFERER'] = 'http://test.host'
  end

  describe 'GET "index"' do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end

    it 'returns the proper animal_weight' do
      get 'index'
      assigns(:animal_weights).include?(@animal_weight).should == true
    end
  end

  describe 'GET show' do
    it 'assigns the requested animal_weight as @animal_weight' do
      get :show, params: { id: @animal_weight.to_param }
      assigns(:animal_weight).should eq(@animal_weight)
    end
  end

  describe 'GET new' do
    it 'assigns a new animal_weight as @animal_weight' do
      get :new
      assigns(:animal_weight).should be_a_new(AnimalWeight)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested animal_weight as @animal_weight' do
      get :edit, params: { id: @animal_weight.to_param }
      assigns(:animal_weight).should eq(@animal_weight)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      # it "creates a new animal_weight" do
      #   expect {
      #     post :create, {:animal_weight => FactoryGirl.attributes_for(:animal_weight)}
      #   }.to change(AnimalWeight, :count).by(1)
      # end

      # it "assigns a newly created animal_weight as @animal_weight" do
      #   post :create, {:animal_weight =>  FactoryGirl.attributes_for(:animal_weight)}
      #   assigns(:animal_weight).should be_a(AnimalWeight)
      #   assigns(:animal_weight).should be_persisted
      # end

      it 'redirects to the created animal_weight' do
        post :create, params: { animal_weight: FactoryGirl.attributes_for(:animal_weight) }
        response.should redirect_to 'http://test.host'
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'assigns the requested animal_weight as @animal_weight' do
        put :update, params: { id: @animal_weight, animal_weight: FactoryGirl.attributes_for(:animal_weight) }
        assigns(:animal_weight).should eq(@animal_weight)
      end

      it 'changes @animal_weight attributes' do
        put :update, params: { id: @animal_weight.to_param, animal_weight: { 'weight' => 50 } }
        @animal_weight.reload
        @animal_weight.weight.should eq(50)
      end

      it 'redirects to the animal_weight' do
        put :update, params: { id: @animal_weight, animal_weight: FactoryGirl.attributes_for(:animal_weight) }
        response.should redirect_to(admin_animal_weight_path(@animal_weight))
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested animal_weight' do
      expect do
        delete :destroy, params: { id: @animal_weight.to_param }
      end.to change(AnimalWeight, :count).by(-1)
    end

    it 'redirects to the animal_weights list' do
      delete :destroy, params: { id: @animal_weight.to_param }
      response.should redirect_to(admin_animal_weights_url)
    end
  end
end
