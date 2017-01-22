require 'spec_helper'

describe Admin::AnimalsController do
  before :each do
    login_user

    @animal = FactoryGirl.create(:animal, organization_id: subject.current_user.organization_id)

    request.env['HTTP_REFERER'] = 'http://test.host'
  end

  describe 'GET "index"' do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end

    it 'returns the proper animal' do
      get 'index'
      assigns(:animals).include?(@animal).should == true
    end
  end

  describe 'GET show' do
    it 'assigns the requested animal as @animal' do
      get :show, params: { id: @animal.to_param }
      assigns(:animal).should eq(@animal)
    end
  end

  describe 'GET new' do
    it 'assigns a new animal as @animal' do
      get :new
      assigns(:animal).should be_a_new(Animal)
    end
  end

  # describe "GET edit" do
  #   it "assigns the requested animal as @animal" do
  #     get :edit, {:id => @animal.to_param}
  #     assigns(:animal).should eq(@animal)
  #   end
  # end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new animal" do
  #       expect {
  #         post :create, {:animal => FactoryGirl.attributes_for(:animal)}
  #       }.to change(Animal, :count).by(1)
  #     end

  #     it "assigns a newly created animal as @animal" do
  #       post :create, {:animal =>  FactoryGirl.attributes_for(:animal)}
  #       assigns(:animal).should be_a(Animal)
  #       assigns(:animal).should be_persisted
  #     end

  #     it "redirects to the created animal" do
  #       post :create, {:animal =>  FactoryGirl.attributes_for(:animal)}
  #       response.should redirect_to(admin_animal_path(Animal.last))
  #     end
  #   end
  # end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'assigns the requested animal as @animal' do
        put :update, params: { id: @animal, animal: FactoryGirl.attributes_for(:animal) }
        assigns(:animal).should eq(@animal)
      end

      it 'changes @animal attributes' do
        put :update, params: { id: @animal.to_param, animal: { 'name' => 'Edit' } }
        @animal.reload
        @animal.name.should eq('Edit')
      end

      it 'redirects to the animal' do
        put :update, params: { id: @animal, animal: FactoryGirl.attributes_for(:animal) }
        response.should redirect_to(admin_animal_path(@animal))
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested animal' do
      expect do
        delete :destroy, params: { id: @animal.to_param }
      end.to change(Animal, :count).by(-1)
    end

    it 'redirects to the animals list' do
      delete :destroy, params: { id: @animal.to_param }
      response.should redirect_to(admin_animals_url)
    end
  end

  describe 'GET duplicate' do
    it 'duplicates a new animal' do
      expect do
        get :duplicate, params: { id: @animal.to_param }
      end.to change(Animal, :count).by(1)
    end
  end

  describe 'GET cage_card' do
    it 'assigns the requested animal as @animal' do
      get :cage_card, params: { id: @animal.to_param }
      assigns(:animal).should eq(@animal)
    end
  end

  # describe "GET qr_code" do
  #   it "assigns the requested animal as @animal" do
  #     get :qr_code, {:id => @animal.to_param, :format => :html}
  #     assigns(:animal).should eq(@animal)
  #   end
  # end
end
