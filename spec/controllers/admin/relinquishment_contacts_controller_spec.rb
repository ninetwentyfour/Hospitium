require 'spec_helper'

describe Admin::RelinquishmentContactsController do
  before :each do
    login_user

    @relinquishment_contact = FactoryGirl.create(:relinquishment_contact, organization_id: subject.current_user.organization_id)
  end

  describe 'GET "index"' do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end

    it 'returns the proper relinquishment_contact' do
      get 'index'
      assigns(:relinquishment_contacts).include?(@relinquishment_contact).should == true
    end
  end

  describe 'GET show' do
    it 'assigns the requested relinquishment_contact as @relinquishment_contact' do
      get :show, params: { id: @relinquishment_contact.to_param }
      assigns(:relinquishment_contact).should eq(@relinquishment_contact)
    end
  end

  describe 'GET new' do
    it 'assigns a new relinquishment_contact as @relinquishment_contact' do
      get :new
      assigns(:relinquishment_contact).should be_a_new(RelinquishmentContact)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested relinquishment_contact as @relinquishment_contact' do
      get :edit, params: { id: @relinquishment_contact.to_param }
      assigns(:relinquishment_contact).should eq(@relinquishment_contact)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new relinquishment_contact' do
        expect do
          post :create, params: { relinquishment_contact: FactoryGirl.attributes_for(:relinquishment_contact) }
        end.to change(RelinquishmentContact, :count).by(1)
      end

      it 'assigns a newly created relinquishment_contact as @relinquishment_contact' do
        post :create, params: { relinquishment_contact: FactoryGirl.attributes_for(:relinquishment_contact) }
        assigns(:relinquishment_contact).should be_a(RelinquishmentContact)
        assigns(:relinquishment_contact).should be_persisted
      end

      it 'redirects to the created relinquishment_contact' do
        post :create, params: { relinquishment_contact: FactoryGirl.attributes_for(:relinquishment_contact) }
        response.should redirect_to(admin_relinquishment_contact_path(RelinquishmentContact.order(created_at: :desc).first))
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'assigns the requested relinquishment_contact as @relinquishment_contact' do
        put :update, params: { id: @relinquishment_contact, relinquishment_contact: FactoryGirl.attributes_for(:relinquishment_contact) }
        assigns(:relinquishment_contact).should eq(@relinquishment_contact)
      end

      it 'changes @relinquishment_contact attributes' do
        put :update, params: { id: @relinquishment_contact.to_param, relinquishment_contact: { 'first_name' => 'Edit' } }
        @relinquishment_contact.reload
        @relinquishment_contact.first_name.should eq('Edit')
      end

      it 'redirects to the relinquishment_contact' do
        put :update, params: { id: @relinquishment_contact, relinquishment_contact: FactoryGirl.attributes_for(:relinquishment_contact) }
        response.should redirect_to(admin_relinquishment_contact_path(@relinquishment_contact))
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested relinquishment_contact' do
      expect do
        delete :destroy, params: { id: @relinquishment_contact.to_param }
      end.to change(RelinquishmentContact, :count).by(-1)
    end

    it 'redirects to the relinquishment_contacts list' do
      delete :destroy, params: { id: @relinquishment_contact.to_param }
      response.should redirect_to(admin_relinquishment_contacts_url)
    end
  end
end
