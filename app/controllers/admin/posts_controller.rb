class Admin::PostsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json
  
  # GET /posts  
  # GET /posts.xml
  def index
    canonical_url("/posts")
    @posts = Post.all

    respond_with(@posts)
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    canonical_url("/posts/#{params[:id]}")
    @post = Post.find(params[:id])

    respond_with(@post)
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_with(@post)
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = 'Post was successfully created.'
    else
      flash[:error] = 'Post was not successfully created.'
    end
    
    respond_with(@post, :location => admin_post_path(@post))
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    
    respond_with(@post, :location => admin_post_path(@post))
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Successfully destroyed post.'
    
    respond_with(@post, :location => admin_posts_path)
  end
end
