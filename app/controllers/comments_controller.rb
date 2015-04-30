class CommentsController < ApplicationController
  before_action :require_user 

  def create
    @comment = Comment.new(params.require(:comment).permit(:body))
    @post = Post.find_by(slug: params[:post_id])

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
      
    respond_to do |format|
      format.html {redirect_to :back}
      format.js 
    end

  end

end