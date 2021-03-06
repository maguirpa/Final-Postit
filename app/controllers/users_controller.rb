class UsersController < ApplicationController 
  before_action :set_user, only: [:show, :edit, :update]
  before_action :same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Registration successful.'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    if params[:mark] == 'newest'
      @posts = @user.posts.order(created_at: :desc)
    elsif params[:mark] == 'rank'
      @posts = @user.posts.sort_by{|x| x.total_votes}.reverse
    else
      @posts = @user.posts.order(created_at: :desc)
    end
    @comments = @user.comments.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile updated successfully."
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
   @user = User.find_by(slug: params[:id]) 
  end

  def same_user
    if @user != current_user
      flash[:error] = "You do not have access to that."
      redirect_to root_path
    end
  end

end