class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create 
    @post = Post.new(post_params)
    @post.creator = User.first

    if @post.save
      flash[:notice] = 'Apartment saved successfully'
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def edit    
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Apartment updated successfully"
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :link, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])    
  end

end
