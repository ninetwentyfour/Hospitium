require 'spec_helper'

#this is the public animals controller
describe Admin::AdoptionContactsController do
  before :each do
    login_user

    @adoption_contact = FactoryGirl.create(:adoption_contact, :organization_id => subject.current_user.organization_id)
  end

  describe 'GET "index"' do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it 'returns the proper adoption contact' do
      get 'index'
      assigns(:adoption_contacts).should =~ [@adoption_contact]
    end

  end

  describe "GET show" do
    it "assigns the requested adoption_contact as @adoption_contact" do
      get :show, {:id => @adoption_contact.to_param}
      assigns(:adoption_contact).should eq(@adoption_contact)
    end
  end

  describe "GET new" do
    it "assigns a new adoption_contact as @adoption_contact" do
      get :new
      assigns(:adoption_contact).should be_a_new(AdoptionContact)
    end
  end

  describe "GET edit" do
    it "assigns the requested adoption_contact as @adoption_contact" do
      get :edit, {:id => @adoption_contact.to_param}
      assigns(:adoption_contact).should eq(@adoption_contact)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new adoption_contact" do
        expect {
          post :create, {:adoption_contact => FactoryGirl.attributes_for(:adoption_contact)}
        }.to change(AdoptionContact, :count).by(1)
      end

      it "assigns a newly created adoption_contact as @adoption_contact" do
        post :create, {:adoption_contact =>  FactoryGirl.attributes_for(:adoption_contact)}
        assigns(:adoption_contact).should be_a(AdoptionContact)
        assigns(:adoption_contact).should be_persisted
      end

      it "redirects to the created adoption_contact" do
        post :create, {:adoption_contact =>  FactoryGirl.attributes_for(:adoption_contact)}
        response.should redirect_to(admin_adoption_contact_path(AdoptionContact.order(created_at: :desc).first))
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested adoption_contact as @adoption_contact" do
        put :update, id: @adoption_contact, adoption_contact: FactoryGirl.attributes_for(:adoption_contact)
        assigns(:adoption_contact).should eq(@adoption_contact) 
      end
      
      it "changes @adoption_contact attributes" do
        put :update, {:id => @adoption_contact.to_param, :adoption_contact => { "first_name" => "Edit" }}
        @adoption_contact.reload
        @adoption_contact.first_name.should eq("Edit")
      end

      it "redirects to the adoption_contact" do
        put :update, id: @adoption_contact, adoption_contact: FactoryGirl.attributes_for(:adoption_contact)
        response.should redirect_to(admin_adoption_contact_path(@adoption_contact))
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested adoption_contact" do
      expect {
        delete :destroy, {:id => @adoption_contact.to_param}
      }.to change(AdoptionContact, :count).by(-1)
    end

    it "redirects to the adoption_contacts list" do
      delete :destroy, {:id => @adoption_contact.to_param}
      response.should redirect_to(admin_adoption_contacts_url)
    end
  end
end