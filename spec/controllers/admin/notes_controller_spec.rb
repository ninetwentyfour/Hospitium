require 'spec_helper'

describe Admin::NotesController do
  before :each do
    login_user

    @animal = FactoryGirl.create(:animal, organization_id: subject.current_user.organization_id)
    @note = FactoryGirl.create(:note, user_id: subject.current_user.id, animal_id: @animal.id)

    request.env['HTTP_REFERER'] = 'http://test.host/'
  end

  describe 'GET "index"' do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end

    it 'returns the proper note' do
      get 'index'
      assigns(:notes).include?(@note).should == true
    end
  end

  describe 'GET show' do
    it 'assigns the requested note as @note' do
      get :show, params: { id: @note.to_param }
      assigns(:note).should eq(@note)
    end
  end

  describe 'GET new' do
    it 'assigns a new note as @note' do
      get :new
      assigns(:note).should be_a_new(Note)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      # it "creates a new note" do
      #   expect {
      #     post :create, {:note => FactoryGirl.attributes_for(:note)}
      #   }.to change(Note, :count).by(1)
      # end

      it 'assigns a newly created note as @note' do
        post :create, params: { note: FactoryGirl.attributes_for(:note) }
        assigns(:note).should be_a(Note)
      end

      it 'redirects to the created note' do
        post :create, params: { note: FactoryGirl.attributes_for(:note) }
        response.should redirect_to 'http://test.host/'
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested note' do
      expect do
        delete :destroy, params: { id: @note.to_param }
      end.to change(Note, :count).by(-1)
    end

    it 'redirects to the notes list' do
      delete :destroy, params: { id: @note.to_param }
      response.should redirect_to 'http://test.host/'
    end
  end
end
