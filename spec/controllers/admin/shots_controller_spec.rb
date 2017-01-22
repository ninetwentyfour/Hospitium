require 'spec_helper'

describe Admin::ShotsController do
  before :each do
    login_user

    @shot = FactoryGirl.create(:shot, organization_id: subject.current_user.organization_id)

    request.env['HTTP_REFERER'] = 'http://test.host'
  end

  describe 'GET "index"' do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end

    it 'returns the proper shot' do
      get 'index'
      assigns(:shots).include?(@shot).should == true
    end
  end

  describe 'GET show' do
    it 'assigns the requested shot as @shot' do
      get :show, params: { id: @shot.to_param }
      assigns(:shot).should eq(@shot)
    end
  end

  describe 'GET new' do
    it 'assigns a new shot as @shot' do
      get :new
      assigns(:shot).should be_a_new(Shot)
    end
  end

  # describe "GET edit" do
  #   it "assigns the requested shot as @shot" do
  #     get :edit, {:id => @shot.to_param}
  #     assigns(:shot).should eq(@shot)
  #   end
  # end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new shot" do
  #       expect {
  #         post :create, {:shot => FactoryGirl.attributes_for(:shot)}
  #       }.to change(Shot, :count).by(1)
  #     end

  #     it "assigns a newly created shot as @shot" do
  #       post :create, {:shot =>  FactoryGirl.attributes_for(:shot)}
  #       assigns(:shot).should be_a(Shot)
  #       assigns(:shot).should be_persisted
  #     end

  #     it "redirects to the created shot" do
  #       post :create, {:shot =>  FactoryGirl.attributes_for(:shot)}
  #       response.should redirect_to(admin_shot_path(Shot.last))
  #     end
  #   end
  # end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'assigns the requested shot as @shot' do
        put :update, params: { id: @shot, shot: FactoryGirl.attributes_for(:shot) }
        assigns(:shot).should eq(@shot)
      end

      # it "changes @shot attributes" do
      #   put :update, {:id => @shot.id, :shot => { "name" => "test" }}
      #   @shot.reload
      #   @shot.name.should eq("edit")
      # end

      it 'redirects to the shot' do
        put :update, params: { id: @shot, shot: FactoryGirl.attributes_for(:shot) }
        response.should redirect_to(admin_shot_path(@shot))
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested shot' do
      expect do
        delete :destroy, params: { id: @shot.to_param }
      end.to change(Shot, :count).by(-1)
    end

    it 'redirects to the shots list' do
      delete :destroy, params: { id: @shot.to_param }
      response.should redirect_to(admin_shots_url)
    end
  end
end
