class SessionsController < ApplicationController
  def home
  end

  #login
  def new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      #add flash message
      redirect_to login_path
    end
  end

  #logout
  def destroy
    session.clear
    redirect_to root_path
  end
  

end