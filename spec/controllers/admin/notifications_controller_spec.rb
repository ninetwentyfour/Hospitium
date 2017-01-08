require 'spec_helper'

describe Admin::NotificationsController do
  before :each do
    login_admin

    # Notification.skip_callback(:create, :after, :send_public_tweet)
    # Notification.skip_callback(:update, :after, :send_public_tweet)

    @notification = FactoryGirl.create(:notification)
  end

  describe 'GET "index"' do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it 'returns the proper notification' do
      get 'index'
      assigns(:notifications).include?(@notification).should == true
    end

  end

  describe "GET show" do
    it "assigns the requested notification as @notification" do
      get :show, {:id => @notification.to_param}
      assigns(:notification).should eq(@notification)
    end
  end

  describe "GET new" do
    it "assigns a new notification as @notification" do
      get :new
      assigns(:notification).should be_a_new(Notification)
    end
  end

  describe "GET edit" do
    it "assigns the requested notification as @notification" do
      get :edit, {:id => @notification.to_param}
      assigns(:notification).should eq(@notification)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new notification" do
        expect {
          post :create, {:notification => FactoryGirl.attributes_for(:notification)}
        }.to change(Notification, :count).by(1)
      end

      it "assigns a newly created notification as @notification" do
        post :create, {:notification =>  FactoryGirl.attributes_for(:notification)}
        assigns(:notification).should be_a(Notification)
        assigns(:notification).should be_persisted
      end

      it "redirects to the created notification" do
        post :create, {:notification =>  FactoryGirl.attributes_for(:notification)}
        response.should redirect_to(admin_notification_path(Notification.order(created_at: :desc).first))
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested notification as @notification" do
        put :update, id: @notification, notification: FactoryGirl.attributes_for(:notification)
        assigns(:notification).should eq(@notification)
      end

      it "changes @notification attributes" do
        put :update, {:id => @notification.to_param, :notification => { "message" => "Edit" }}
        @notification.reload
        @notification.message.should eq("Edit")
      end

      it "redirects to the notification" do
        put :update, id: @notification, notification: FactoryGirl.attributes_for(:notification)
        response.should redirect_to(admin_notification_path(@notification))
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested notification" do
      expect {
        delete :destroy, {:id => @notification.to_param}
      }.to change(Notification, :count).by(-1)
    end

    it "redirects to the notifications list" do
      delete :destroy, {:id => @notification.to_param}
      response.should redirect_to(admin_notifications_url)
    end
  end
end
