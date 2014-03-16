require 'spec_helper'

#this is the public animals controller
describe HomeController do
  
  describe 'GET' do
    it "index returns http success" do
      get 'index'
      response.should be_success
    end

    it "about returns http success" do
      get 'about'
      response.should be_success
    end

    it "features returns http success" do
      get 'features'
      response.should be_success
    end

    it "privacy returns http success" do
      get 'privacy'
      response.should be_success
    end

    it "why returns http success" do
      get 'why'
      response.should be_success
    end

    it "changes returns http success" do
      VCR.use_cassette('controllers/home_changes') do
        get 'changes'
        response.should be_success
      end
    end
  end
end