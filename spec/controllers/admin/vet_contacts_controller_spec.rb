require 'spec_helper'

#this is the public animals controller
describe Admin::VetContactsController do
  before :each do
    login_user

    @vet_contact = FactoryGirl.create(:vet_contact, :organization_id => subject.current_user.organization_id)
  end

  describe 'GET "index"' do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it 'returns the proper vet_contact' do
      get 'index'
      assigns(:vet_contacts).should =~ [@vet_contact]
    end

  end

  describe "GET show" do
    it "assigns the requested vet_contact as @vet_contact" do
      get :show, {:id => @vet_contact.to_param}
      assigns(:vet_contact).should eq(@vet_contact)
    end
  end

  describe "GET new" do
    it "assigns a new vet_contact as @vet_contact" do
      get :new
      assigns(:vet_contact).should be_a_new(VetContact)
    end
  end

  describe "GET edit" do
    it "assigns the requested vet_contact as @vet_contact" do
      get :edit, {:id => @vet_contact.to_param}
      assigns(:vet_contact).should eq(@vet_contact)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new vet_contact" do
        expect {
          post :create, {:vet_contact => FactoryGirl.attributes_for(:vet_contact)}
        }.to change(VetContact, :count).by(1)
      end

      it "assigns a newly created vet_contact as @vet_contact" do
        post :create, {:vet_contact =>  FactoryGirl.attributes_for(:vet_contact)}
        assigns(:vet_contact).should be_a(VetContact)
        assigns(:vet_contact).should be_persisted
      end

      it "redirects to the created vet_contact" do
        post :create, {:vet_contact =>  FactoryGirl.attributes_for(:vet_contact)}
        response.should redirect_to(admin_vet_contact_path(VetContact.last))
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested vet_contact as @vet_contact" do
        put :update, id: @vet_contact, vet_contact: FactoryGirl.attributes_for(:vet_contact)
        assigns(:vet_contact).should eq(@vet_contact) 
      end
      
      it "changes @vet_contact attributes" do
        put :update, {:id => @vet_contact.to_param, :vet_contact => { "clinic_name" => "Edit" }}
        @vet_contact.reload
        @vet_contact.clinic_name.should eq("Edit")
      end

      it "redirects to the vet_contact" do
        put :update, id: @vet_contact, vet_contact: FactoryGirl.attributes_for(:vet_contact)
        response.should redirect_to(admin_vet_contact_path(@vet_contact))
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested vet_contact" do
      expect {
        delete :destroy, {:id => @vet_contact.to_param}
      }.to change(VetContact, :count).by(-1)
    end

    # it "redirects to the vet_contacts list" do
    #   delete :destroy, {:id => @vet_contact.to_param}
    #   response.should redirect_to(admin_vet_contacts_url)
    # end
  end
end