class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Signed in successfully.'
      redirect_to root_path
    else
      flash[:erroer] = 'There was something wrong with your username or password'
      render 'new'
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end


end