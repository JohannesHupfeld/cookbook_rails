class ApplicationController < ActionController::Base

  #Gives access to helper methods in the  views 
  helper_method(:current_user, :logged_in?)

  private 
  def current_user
    #If current user is already defined then itll equal @ current_user otherwise itll find by id in the users table
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] #The if prevents calls to the database if no need
  end

  def logged_in?
    !!session[:user_id]
  end

  def redirect_if_not_logged_in
    redirect_to '/' if !logged_in?
  end

  def authorized_to_edit?
    @recipe.user == current_user
  end
end
