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

  def create
    @recipe = current_user.recipes.build(recipe_params) #user_id and recipe are connected -- post belongs to user
    if @recipe.save
      redirect_to recipe_path
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find_by_id(params[:id])
    redirect_to recipes_path if !@recipe
  end

  def edit
    @recipe = Recipe.find_by_id(params[:id])
    redirect_to recipes_path if !@recipe || !authorized_to_edit?
    @recipe.build_category if !@recipe.category
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    redirect_to recipes_path if !@recipe || !authorized_to_edit?
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  


  private

  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :instructions, category_attributes: [:name])
  end
end
