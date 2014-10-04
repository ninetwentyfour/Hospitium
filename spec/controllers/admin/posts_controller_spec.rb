require 'spec_helper'

describe Admin::PostsController do
  before :each do
    login_admin

    Post.skip_callback(:create, :after, :send_public_tweet)
    Post.skip_callback(:update, :after, :send_public_tweet)

    @post = FactoryGirl.create(:post)
  end

  describe 'GET "index"' do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it 'returns the proper post' do
      get 'index'
      assigns(:posts).include?(@post).should == true
    end

  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      get :show, {:id => @post.id}
      assigns(:post).should eq(@post)
    end
  end

  describe "GET new" do
    it "assigns a new post as @post" do
      get :new
      assigns(:post).should be_a_new(Post)
    end
  end

  describe "GET edit" do
    it "assigns the requested post as @post" do
      get :edit, {:id => @post.id}
      assigns(:post).should eq(@post)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new post" do
        expect {
          post :create, {:post => FactoryGirl.attributes_for(:post)}
        }.to change(Post, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        post :create, {:post =>  FactoryGirl.attributes_for(:post)}
        assigns(:post).should be_a(Post)
        assigns(:post).should be_persisted
      end

      it "redirects to the created post" do
        post :create, {:post =>  FactoryGirl.attributes_for(:post)}
        response.should redirect_to(admin_post_path(Post.order(created_at: :desc).first))
      end
    end
  end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "assigns the requested post as @post" do
  #       put :update, id: @post, post: FactoryGirl.attributes_for(:post)
  #       assigns(:post).should eq(@post) 
  #     end
      
  #     it "changes @post attributes" do
  #       put :update, {:id => @post.id, :post => { "content" => "Edit" }}
  #       @post.reload
  #       @post.content.should eq("Edit")
  #     end

  #     it "redirects to the post" do
  #       put :update, id: @post, post: FactoryGirl.attributes_for(:post)
  #       response.should redirect_to(admin_post_path(@post))
  #     end
  #   end
  # end

  describe "DELETE destroy" do
    it "destroys the requested post" do
      expect {
        delete :destroy, {:id => @post.id}
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      delete :destroy, {:id => @post.id}
      response.should redirect_to(admin_posts_url)
    end
  end
end