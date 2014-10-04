require 'spec_helper'

#this is the public animals controller
describe Admin::VolunteerContactsController do
  before :each do
    login_user

    @volunteer_contact = FactoryGirl.create(:volunteer_contact, :organization_id => subject.current_user.organization_id)
  end

  describe 'GET "index"' do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it 'returns the proper volunteer_contact' do
      get 'index'
      assigns(:volunteer_contacts).should =~ [@volunteer_contact]
    end

  end

  describe "GET show" do
    it "assigns the requested volunteer_contact as @volunteer_contact" do
      get :show, {:id => @volunteer_contact.to_param}
      assigns(:volunteer_contact).should eq(@volunteer_contact)
    end
  end

  describe "GET new" do
    it "assigns a new volunteer_contact as @volunteer_contact" do
      get :new
      assigns(:volunteer_contact).should be_a_new(VolunteerContact)
    end
  end

  describe "GET edit" do
    it "assigns the requested volunteer_contact as @volunteer_contact" do
      get :edit, {:id => @volunteer_contact.to_param}
      assigns(:volunteer_contact).should eq(@volunteer_contact)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new volunteer_contact" do
        expect {
          post :create, {:volunteer_contact => FactoryGirl.attributes_for(:volunteer_contact)}
        }.to change(VolunteerContact, :count).by(1)
      end

      it "assigns a newly created volunteer_contact as @volunteer_contact" do
        post :create, {:volunteer_contact =>  FactoryGirl.attributes_for(:volunteer_contact)}
        assigns(:volunteer_contact).should be_a(VolunteerContact)
        assigns(:volunteer_contact).should be_persisted
      end

      it "redirects to the created volunteer_contact" do
        post :create, {:volunteer_contact =>  FactoryGirl.attributes_for(:volunteer_contact)}
        response.should redirect_to(admin_volunteer_contact_path(VolunteerContact.order(created_at: :desc).first))
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested volunteer_contact as @volunteer_contact" do
        put :update, id: @volunteer_contact, volunteer_contact: FactoryGirl.attributes_for(:volunteer_contact)
        assigns(:volunteer_contact).should eq(@volunteer_contact) 
      end
      
      it "changes @volunteer_contact attributes" do
        put :update, {:id => @volunteer_contact.to_param, :volunteer_contact => { "first_name" => "Edit" }}
        @volunteer_contact.reload
        @volunteer_contact.first_name.should eq("Edit")
      end

      it "redirects to the volunteer_contact" do
        put :update, id: @volunteer_contact, volunteer_contact: FactoryGirl.attributes_for(:volunteer_contact)
        response.should redirect_to(admin_volunteer_contact_path(@volunteer_contact))
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested volunteer_contact" do
      expect {
        delete :destroy, {:id => @volunteer_contact.to_param}
      }.to change(VolunteerContact, :count).by(-1)
    end

    it "redirects to the volunteer_contacts list" do
      delete :destroy, {:id => @volunteer_contact.to_param}
      response.should redirect_to(admin_volunteer_contacts_url)
    end
  end
end