require 'spec_helper'

describe Admin::FosterContactsController do
  before :each do
    login_user

    @foster_contact = FactoryGirl.create(:foster_contact, :organization_id => subject.current_user.organization_id)
  end

  describe 'GET "index"' do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it 'returns the proper foster contact' do
      get 'index'
      assigns(:foster_contacts).should =~ [@foster_contact]
    end

  end

  describe "GET show" do
    it "assigns the requested foster_contact as @foster_contact" do
      get :show, {:id => @foster_contact.to_param}
      assigns(:foster_contact).should eq(@foster_contact)
    end
  end

  describe "GET new" do
    it "assigns a new foster_contact as @foster_contact" do
      get :new
      assigns(:foster_contact).should be_a_new(FosterContact)
    end
  end

  describe "GET edit" do
    it "assigns the requested foster_contact as @foster_contact" do
      get :edit, {:id => @foster_contact.to_param}
      assigns(:foster_contact).should eq(@foster_contact)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new foster_contact" do
        expect {
          post :create, {:foster_contact => FactoryGirl.attributes_for(:foster_contact)}
        }.to change(FosterContact, :count).by(1)
      end

      it "assigns a newly created foster_contact as @foster_contact" do
        post :create, {:foster_contact =>  FactoryGirl.attributes_for(:foster_contact)}
        assigns(:foster_contact).should be_a(FosterContact)
        assigns(:foster_contact).should be_persisted
      end

      it "redirects to the created foster_contact" do
        post :create, {:foster_contact =>  FactoryGirl.attributes_for(:foster_contact)}
        response.should redirect_to(admin_foster_contact_path(FosterContact.order(created_at: :desc).first))
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested foster_contact as @foster_contact" do
        put :update, id: @foster_contact, foster_contact: FactoryGirl.attributes_for(:foster_contact)
        assigns(:foster_contact).should eq(@foster_contact) 
      end
      
      it "changes @foster_contact attributes" do
        put :update, {:id => @foster_contact.to_param, :foster_contact => { "first_name" => "Edit" }}
        @foster_contact.reload
        @foster_contact.first_name.should eq("Edit")
      end

      it "redirects to the foster_contact" do
        put :update, id: @foster_contact, foster_contact: FactoryGirl.attributes_for(:foster_contact)
        response.should redirect_to(admin_foster_contact_path(@foster_contact))
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested foster_contact" do
      expect {
        delete :destroy, {:id => @foster_contact.to_param}
      }.to change(FosterContact, :count).by(-1)
    end

    it "redirects to the foster_contacts list" do
      delete :destroy, {:id => @foster_contact.to_param}
      response.should redirect_to(admin_foster_contacts_url)
    end
  end
end