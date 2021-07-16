class RecipesController < ApplicationController
  before_action :redirect_if_not_logged_in

  def new
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
      @recipe = @user.recipes.build
    else
      @recipe = Recipe.new
    end
    #build category
  end

  def index 
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
      @recipes = @user.recipes
    else
      #error
      @recipes = Recipe.alpha.includes(:category, :user)
    end
    @recipes = Recipe.search(params[:q].downcase) if params[:q] && !params[:q].empty?
  end

  


  private

  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :instructions, category_attributes: [:name])
  end
end
