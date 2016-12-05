class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy, :accept]

  def create
    authorize Comment
    @comment = @post.comments.create(comment_params)
    @comment.save
  end

  def edit
    authorize @comment
  end

  def update
    authorize @comment
    @comment.update(comment_params)
  end

  def destroy
    authorize @comment
    @comment.destroy
  end

  def accept
    authorize @comment
    # Only one comment can be accepted.
    accepted_comment = @post.comments.find_by(status: 'accepted')
    if @comment != accepted_comment
      @comment.update_attribute :status, 'accepted'
    else
      @comment.status = 'normal'
    end
    accepted_comment.try(:update_attribute, :status, 'normal')
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:post_id, :user_id, :content, :position)
  end
end
