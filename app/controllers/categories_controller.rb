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
    sort_by
  end

end