class RecipesController < ApplicationController
  before_action :redirect_if_not_logged_in

  def new
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
      @recipe = @user.recipes.build
    else
      @recipe = Recipe.new
    end
    @recipe.build_category
  end

  def index 
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
      @recipes = @user.recipes
    else
      @error = "This user doesn't exist" if params[:user_id]
      @recipes = Recipe.alpha
    end
    @recipes = Recipe.search(params[:q].downcase) if params[:q] && !params[:q].empty?
  end

  def create
    @recipe = current_user.recipes.build(recipe_params) #user_id and recipe are connected -- post belongs to user
    if @recipe.save
      flash[:message] = "Recipe successfully created"
      redirect_to recipes_path
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
      flash[:message] = "Recipe successfully updated"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    if current_user
      @recipe.destroy
      flash[:message] = "Recipe successfully deleted"
      redirect_to recipe_path
    else
      render :show
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :instructions, category_attributes: [:name])
  end
end
