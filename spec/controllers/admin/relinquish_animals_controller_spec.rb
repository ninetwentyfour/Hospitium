require 'spec_helper'

# this is the public animals controller
describe Admin::RelinquishAnimalsController do
  before(:each) do
    login_user
    @user = subject.current_user

    @animal = FactoryGirl.create(:animal, organization_id: @user.organization_id)
    @relinquishment_contact = FactoryGirl.create(:relinquishment_contact, organization_id: @user.organization_id)
    @relinquish_animal = FactoryGirl.create(:relinquish_animal, animal_id: @animal.id, relinquishment_contact_id: @relinquishment_contact.id)

    request.env['HTTP_REFERER'] = 'http://test.host'
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new relinquish_animal' do
        RelinquishAnimal.observers.disable :all do
          expect do
            post :create, params: { relinquish_animal: { animal_id: @animal.id, relinquishment_contact_id: @relinquishment_contact.id } }
          end.to change(RelinquishAnimal, :count).by(1)
        end
      end

      it 'assigns a newly created relinquish_animal as @relinquish_animal' do
        RelinquishAnimal.observers.disable :all do
          post :create, params: { relinquish_animal: { animal_id: @animal.id, relinquishment_contact_id: @relinquishment_contact.id } }
          assigns(:relinquish_animal).should be_a(RelinquishAnimal)
          assigns(:relinquish_animal).should be_persisted
        end
      end

      it 'redirects to the created back' do
        RelinquishAnimal.observers.disable :all do
          post :create, params: { relinquish_animal: { animal_id: @animal.id, relinquishment_contact_id: @relinquishment_contact.id } }
          response.should redirect_to 'http://test.host'
        end
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested relinquish_animal' do
      expect do
        delete :destroy, params: { id: @relinquish_animal.animal.id, relinquish: @relinquish_animal.relinquishment_contact.id }
      end.to change(RelinquishAnimal, :count).by(-1)
    end

    it 'redirects to back' do
      delete :destroy, params: { id: @relinquish_animal.animal.id, relinquish: @relinquish_animal.relinquishment_contact.id }
      response.should redirect_to 'http://test.host'
    end
  end
end
