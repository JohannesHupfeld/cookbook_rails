class UsersController < ApplicationController
  def new
    @user = User.new
  end

  #signup 
  def create 
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id 
      flash[:message] = "Successfully created account!"      
      redirect_to @user
    else
      render :new
    end
  end

  def show
    redirect_if_not_logged_in
    @user = User.find_by_id(params[:id]) #if it doesnt find anything find_by_id will throw nil whereas just find will throw error
    redirect_to '/' if !@user
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end


end
