require 'spec_helper'

describe Admin::HomeController do
  before :each do
    login_user
  end

  describe 'GET "index"' do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it 'returns the presenter' do
      get 'index'
      assigns(:presenter).should_not be_blank
    end

  end
end