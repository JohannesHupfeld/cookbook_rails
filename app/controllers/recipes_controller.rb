class RecipesController < ApplicationController
  before_action :redirect_if_not_logged_in

  

  private

  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :instructions, category_attributes: [:name])
  end
end
