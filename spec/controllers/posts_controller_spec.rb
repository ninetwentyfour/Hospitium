require 'spec_helper'

#this is the public posts controller
describe PostsController do
  before :each do
    # Post.skip_callback(:create, :after, :send_public_tweet)
    # Post.skip_callback(:update, :after, :send_public_tweet)

    @post = FactoryGirl.create(:post)
  end

  describe 'GET "index"' do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it 'returns the proper post' do
      get 'index'
      assigns(:posts).should =~ [@post]
    end

  end

  describe 'GET "show"' do
    it "returns http success" do
      get :show, :id => @post.slug
      response.should be_success
    end

    it "should find the account by its id" do
      get :show, :id => @post.slug
      assigns(:post).title.should == @post.title
    end
  end

  describe 'GET "feed"' do
    it "returns http success" do
      get :feed, :format => :rss
      response.should be_success
    end

    it "returns the proper post" do
      get :feed, :format => :rss
      assigns(:posts).should =~ [@post]
    end
  end
end
