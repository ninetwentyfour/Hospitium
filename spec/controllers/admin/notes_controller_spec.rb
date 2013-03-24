require 'spec_helper'

describe Admin::NotesController do
  before :each do
    login_user

    @animal = FactoryGirl.create(:animal, :organization_id => subject.current_user.organization_id)
    @note = FactoryGirl.create(:note, :user_id => subject.current_user.id, :animal_id => @animal.id)

    request.env["HTTP_REFERER"] = "http://test.host/"
  end

  describe 'GET "index"' do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it 'returns the proper note' do
      get 'index'
      assigns(:notes).include?(@note).should == true
    end

  end

  describe "GET show" do
    it "assigns the requested note as @note" do
      get :show, {:id => @note.to_param}
      assigns(:note).should eq(@note)
    end
  end

  describe "GET new" do
    it "assigns a new note as @note" do
      get :new
      assigns(:note).should be_a_new(Note)
    end
  end

  describe "GET edit" do
    it "assigns the requested note as @note" do
      get :edit, {:id => @note.to_param}
      assigns(:note).should eq(@note)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      # it "creates a new note" do
      #   expect {
      #     post :create, {:note => FactoryGirl.attributes_for(:note)}
      #   }.to change(Note, :count).by(1)
      # end

      it "assigns a newly created note as @note" do
        post :create, {:note =>  FactoryGirl.attributes_for(:note)}
        assigns(:note).should be_a(Note)
      end

      it "redirects to the created note" do
        post :create, {:note =>  FactoryGirl.attributes_for(:note)}
        response.should redirect_to "http://test.host/"
      end
    end
  end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "assigns the requested note as @note" do
  #       put :update, id: @note, note: FactoryGirl.attributes_for(:note)
  #       assigns(:note).should eq(@note) 
  #     end
      
  #     it "changes @note attributes" do
  #       put :update, {:id => @note.to_param, :note => { "note" => "Edit" }}
  #       @note.reload
  #       @note.note.should eq("Edit")
  #     end

  #     it "redirects to the note" do
  #       put :update, id: @note, note: FactoryGirl.attributes_for(:note)
  #       response.should redirect_to "http://test.host/"
  #     end
  #   end
  # end

  describe "DELETE destroy" do
    it "destroys the requested note" do
      expect {
        delete :destroy, {:id => @note.to_param}
      }.to change(Note, :count).by(-1)
    end

    it "redirects to the notes list" do
      delete :destroy, {:id => @note.to_param}
      response.should redirect_to "http://test.host/"
    end
  end
end