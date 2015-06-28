class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update, :upvote]

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:pin_id])
    @comment = @post.comments.build(comments_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "comment was saved!"
      render post_path(@post)
    else
      render '/posts/show'
    end
  end

  def edit
  end

  def update
    if @comment.save
      render posts_path(@comment.post)
    else
      render '/posts/show'
    end
  end

  def destroy
    @comment.delete
  end

  def upvote
    @comment.upvote_by current_user
    redirect_to :back
  end

  private

  def comments_params
    params.require(:comments).permit(:description)
  end

  def find_pin
    @post = Post.find(params[:pin_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
