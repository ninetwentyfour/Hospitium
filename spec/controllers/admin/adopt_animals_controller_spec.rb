require 'spec_helper'

#this is the public animals controller
describe Admin::AdoptAnimalsController do
  before(:each) do
    login_user
    @user = subject.current_user

    @animal = FactoryGirl.create(:animal, :organization_id => @user.organization_id)
    @adoption_contact = FactoryGirl.create(:adoption_contact, :organization_id => @user.organization_id)
    @adopt_animal = FactoryGirl.create(:adopt_animal, :animal_id => @animal.id, :adoption_contact_id => @adoption_contact.id)

    request.env["HTTP_REFERER"] = "http://test.host"
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new adopt_animal" do
        AdoptAnimal.observers.disable :all do
          expect {
            post :create, {:adopt_animal => {:animal_id => @animal.id, :adoption_contact_id => @adoption_contact.id}}
          }.to change(AdoptAnimal, :count).by(1)
        end
      end

      it "assigns a newly created adopt_animal as @adopt_animal" do
        AdoptAnimal.observers.disable :all do
          post :create, {:adopt_animal => {:animal_id => @animal.id, :adoption_contact_id => @adoption_contact.id}}
          assigns(:adopt_animal).should be_a(AdoptAnimal)
          assigns(:adopt_animal).should be_persisted
        end
      end

      it "redirects to the created back" do
        AdoptAnimal.observers.disable :all do
          post :create, {:adopt_animal => {:animal_id => @animal.id, :adoption_contact_id => @adoption_contact.id}}
          response.should redirect_to "http://test.host"
        end
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested adopt_animal" do
      expect {
        delete :destroy, {:id => @adopt_animal.animal.id, :adopt => @adopt_animal.adoption_contact.id}
      }.to change(AdoptAnimal, :count).by(-1)
    end

    it "redirects to back" do
      delete :destroy, {:id => @adopt_animal.animal.id, :adopt => @adopt_animal.adoption_contact.id}
      response.should redirect_to "http://test.host"
    end
  end
end