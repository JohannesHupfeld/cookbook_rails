module RecipesHelper
  def index_display_header
    if @user
      content_tag(:h1, "#{@user.username}'s Recipes:")
    else
      content_tag(:h2, "All Recipes")
    end
  end

  def display_recipes
    if @user.recipes.empty?
      tag.h2(link_to('No recipes yet - create a recipe here', new_recipe_path))
    else
      user = @user == current_user ? 'Your' : "#{@user.username}'s"
      content_tag(:h2, "#{user} #{pluralize(@user.recipes.count, 'Recipe')}:")
    end
  end
end