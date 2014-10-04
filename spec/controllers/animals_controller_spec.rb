require 'spec_helper'

#this is the public animals controller
describe AnimalsController do
  
  describe 'GET "index"' do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it 'returns the proper animal' do
      @public_animal = FactoryGirl.create(:animal, :public => 1)
      get 'index'
      assigns(:animals).should =~ [@public_animal]
    end

  end

  describe 'GET "show"' do
    it "returns http success" do
      @public_animal = FactoryGirl.create(:animal, :public => 1)
      get :show, :id => @public_animal.id
      response.should be_success
    end
    
    it "should find the account by its id" do
      @public_animal = FactoryGirl.create(:animal, :public => 1)
      get :show, :id => @public_animal.id
      assigns(:animal).should == @public_animal
    end
    
    it "should redirect to not available if animal is not public" do
      @not_public_animal = FactoryGirl.create(:animal, :public => 0)
      get :show, :id => @not_public_animal.id
      response.should be_redirect
      response.should redirect_to('/animals/not_available')
    end
    
    # it "should redirect to 404 if animal is not found" do
    #   @public_animal = FactoryGirl.create(:animal, :public => 1)
    #   expect {
    #     get :show, :id => "not_a_animal_id"
    #   }.to raise_error(ActionController::RoutingError)
    # end

  end

  describe 'GET "not_available"' do
    it "returns http success" do
      get 'not_available'
      response.should be_success
    end
  end
end