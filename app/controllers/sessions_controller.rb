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
      flash[:message] = "Invalid email or password"
      redirect_to login_path
    end
  end

   #login with google
   def google
    #find_or_create a user using the attributes auth
    @user = User.find_or_create_by(email: auth["info"]["email"]) do |user| #find user binding pry --auth
      user.username = auth["info"]["first_name"]
      user.password = SecureRandom.hex(10) #generates random password -- does not use their actual google password
    end
    if @user #.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to '/'
    end
  end

  #logout
  def destroy
    session.clear
    redirect_to root_path
  end
  
  private

  def auth
    request.env['omniauth.auth']
  end

end