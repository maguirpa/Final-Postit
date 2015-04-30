class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update, :vote, :destroy]
  before_action :require_user, except: [:show, :index, :vote]

  def index
    if params[:mark] == 'newest'
      @posts = Post.all.order(created_at: :desc)
    elsif params[:mark] == 'rank'
      @posts = Post.all.sort_by{|x| x.total_votes}.reverse
    else
      @posts = Post.all.order(created_at: :desc)
    end
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
    @post.creator = current_user

    if @post.save
      flash[:notice] = 'Apartment saved successfully'
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def edit    
    if !owner?(@post)
      flash[:error] = 'You do not have access to that'
      redirect_to root_path
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Apartment updated successfully"
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    if @post.creator == current_user
      @post.destroy
      flash[:notice] = 'Apartment deleted successfully'
      redirect_to root_path
    else
      flash[:error] = "You can't perform that action"
      redirect_to root_path
    end
  end

  def vote
    Vote.create(voteable: @post, user: current_user, vote: params[:vote])

    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :link, category_ids: [])
  end

  def set_post
    @post = Post.find_by(slug: params[:id])    
  end

end






