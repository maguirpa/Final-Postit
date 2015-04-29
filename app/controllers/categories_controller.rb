class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new

    if @category.update(params.require(:category).permit(:name))
      flash[:notice] = 'Category created successfully'
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
    if params[:mark] == 'newest'
      @posts = @category.posts.order(created_at: :desc)
    elsif params[:mark] == 'rank'
      @posts = @category.posts.sort_by{|x| x.total_votes}.reverse
    else
      @posts = @category.posts.order(created_at: :desc)
    end
  end

end