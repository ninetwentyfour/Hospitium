require 'spec_helper'

describe Admin::UsersController do
  before :each do
    login_user

    @user = FactoryGirl.create(:user, :organization_id => subject.current_user.organization_id)

    request.env["HTTP_REFERER"] = "http://test.host"
  end

  describe 'GET "index"' do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it 'returns the proper user' do
      get 'index'
      assigns(:users).include?(@user).should == true
    end

  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      get :show, {:id => @user.to_param}
      assigns(:user).should eq(@user)
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      get :edit, {:id => @user.to_param}
      assigns(:user).should eq(@user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new user" do
        expect {
          post :create, {:user => FactoryGirl.attributes_for(:user)}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user =>  FactoryGirl.attributes_for(:user)}
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user" do
        post :create, {:user =>  FactoryGirl.attributes_for(:user)}
        response.should redirect_to "http://test.host"
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested user as @user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        assigns(:user).should eq(@user) 
      end
      
      it "changes @user attributes" do
        put :update, {:id => @user.to_param, :user => { "username" => "Edit" }}
        @user.reload
        @user.username.should eq("Edit")
      end

      it "redirects to the user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        response.should redirect_to(admin_user_path(@user))
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      expect {
        delete :destroy, {:id => @user.to_param}
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete :destroy, {:id => @user.to_param}
      response.should redirect_to "http://test.host"
    end
  end
end