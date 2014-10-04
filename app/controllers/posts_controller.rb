class PostsController < ApplicationController
  respond_to :html, :json, :rss

  def index
    canonical_url("/posts")
    @posts = Post.paginate(:page => params[:page], :per_page => 10).order("created_at DESC")

    respond_with(@posts)
  end

  def show
    canonical_url("/posts/#{params[:id]}")
    @post = Rails.cache.fetch("public_post_#{params[:id]}", :expires_in => 60.minutes) do
      Post.find(params[:id])
    end

    respond_with(@post)
  end
  
  def feed
    @posts = Post.all

    respond_with(@posts)
  end
end
