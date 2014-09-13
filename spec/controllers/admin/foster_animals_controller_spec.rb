require 'spec_helper'

describe Admin::FosterAnimalsController do
  before(:each) do
    login_user
    @user = subject.current_user

    @animal = FactoryGirl.create(:animal, :organization_id => @user.organization_id)
    @foster_contact = FactoryGirl.create(:foster_contact, :organization_id => @user.organization_id)
    @foster_animal = FactoryGirl.create(:foster_animal, :animal_id => @animal.id, :foster_contact_id => @foster_contact.id)

    request.env["HTTP_REFERER"] = "http://test.host"
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new foster_animal" do
        FosterAnimal.observers.disable :all do
          expect {
            post :create, {:foster_animal => {:animal_id => @animal.id, :adoption_contact_id => @foster_contact.id}}
          }.to change(FosterAnimal, :count).by(1)
        end
      end

      it "assigns a newly created foster_animal as @foster_animal" do
        FosterAnimal.observers.disable :all do
          post :create, {:foster_animal => {:animal_id => @animal.id, :adoption_contact_id => @foster_contact.id}}
          assigns(:foster_animal).should be_a(FosterAnimal)
          assigns(:foster_animal).should be_persisted
        end
      end

      it "redirects to the created back" do
        FosterAnimal.observers.disable :all do
          post :create, {:foster_animal => {:animal_id => @animal.id, :adoption_contact_id => @foster_contact.id}}
          response.should redirect_to "http://test.host"
        end
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested foster_animal" do
      expect {
        delete :destroy, {:id => @foster_animal.animal.id, :foster => @foster_animal.foster_contact.id}
      }.to change(FosterAnimal, :count).by(-1)
    end

    it "redirects to back" do
      delete :destroy, {:id => @foster_animal.animal.id, :foster => @foster_animal.foster_contact.id}
      response.should redirect_to "http://test.host"
    end
  end
end