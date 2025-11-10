class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit, :update]

  def index
    @posts = Post.limit(Post::POSTS_PER_PAGE).offset(params[:offset])
  end

  def show
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      redirect_to @post, notice: "Post Created Succesfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post Updated Succesfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def vote
    vote = Vote.new(voteable: @post, creator: current_user, vote: params[:vote])

    if vote.save
      flash[:notice] = "Your vote was registered"
    else
      flash[:error] = "You can only vote on a post once"
    end
    
    redirect_back fallback_location: posts_path
  end

  private

  def set_post
    @post = Post.find_by slug: params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def require_creator
    access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
  end
end