class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_vote_and_collection, only: [:show]

  def index
    @posts = Post.send((params[:filter] || :latest).to_sym).page params[:page]
  end

  def show
    authorize @post
  end

  def new
    authorize Post
    @post = current_user.posts.new
  end

  def create
    authorize Post
    @post = current_user.posts.create(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to :root }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_vote_and_collection
    if user_signed_in?
      @vote = current_user.find_vote_for(@post)
      @vote.try(:check_abuse)
      @collection = current_user.find_collection_for(@post)
      @collection.try(:check_abuse)
    else
      @vote = nil
      @collection = nil
    end
  end

  def post_params
    params.require(:post).permit(:user_id, :title, :content, { tag_list: [] })
  end
end
