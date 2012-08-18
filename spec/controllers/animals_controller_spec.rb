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
      get :show, :id => @public_animal.uuid
      response.should be_success
    end
    
    it "should find the account by its id" do
      @public_animal = FactoryGirl.create(:animal, :public => 1)
      get :show, :id => @public_animal.uuid
      assigns(:animal).should == @public_animal
    end

  end
end