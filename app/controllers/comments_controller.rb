class CommentsController < ApplicationController
  before_action :require_user 

  def create
    @comment = Comment.new(params.require(:comment).permit(:body))
    @post = Post.find(params[:post_id])

    @comment.user = current_user
    @comment.post = @post


    if @comment.save
      flash[:notice] = 'Comment saved successfully'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    Vote.create(voteable: @comment, user: current_user, vote: params[:vote])
    redirect_to :back
  end

end