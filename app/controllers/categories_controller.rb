class CategoriesController < ApplicationController

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
    @posts = @category.posts.order(created_at: :desc)
  end

end