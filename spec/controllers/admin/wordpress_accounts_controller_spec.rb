require 'spec_helper'

# this is the public posts controller
describe Admin::WordpressAccountsController do
  before :each do
    login_user

    @wordpress_account = FactoryGirl.create(:wordpress_account,
                                            user_id: subject.current_user.id,
                                            organization_id: subject.current_user.organization_id)
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new wordpress_account' do
        expect do
          post :create, params: { wordpress_account: FactoryGirl.attributes_for(:wordpress_account) }
        end.to change(WordpressAccount, :count).by(1)
      end

      it 'assigns a newly created wordpress_account as @wordpress_account' do
        post :create, params: { wordpress_account: FactoryGirl.attributes_for(:wordpress_account) }
        assigns(:wordpress_account).should be_a(WordpressAccount)
        assigns(:wordpress_account).should be_persisted
      end

      it 'redirects to the created wordpress_account' do
        post :create, params: { wordpress_account: FactoryGirl.attributes_for(:wordpress_account) }
        response.should redirect_to "/admin/users/#{subject.current_user.id}"
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'assigns the requested wordpress_account as @wordpress_account' do
        put :update, params: { id: @wordpress_account, wordpress_account: FactoryGirl.attributes_for(:wordpress_account) }
        assigns(:wordpress).should eq(@wordpress_account)
      end

      it 'changes @wordpress_account attributes' do
        put :update, params: { id: @wordpress_account.to_param, wordpress_account: { 'site_url' => 'http://edit.com' } }
        @wordpress_account.reload
        @wordpress_account.site_url.should eq('http://edit.com')
      end

      it 'redirects to the wordpress_account' do
        put :update, params: { id: @wordpress_account, wordpress_account: FactoryGirl.attributes_for(:wordpress_account) }
        response.should redirect_to "/admin/users/#{subject.current_user.id}"
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested wordpress_account' do
      expect do
        delete :destroy, params: { id: @wordpress_account.to_param }
      end.to change(WordpressAccount, :count).by(-1)
    end

    it 'redirects to the wordpress_accounts list' do
      delete :destroy, params: { id: @wordpress_account.to_param }
      response.should redirect_to "/admin/users/#{subject.current_user.id}"
    end
  end
end
