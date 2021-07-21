class CommentsController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :set_comment, only: [:show, :edit, :update]
  before_action :redirect_if_not_comment_author, only: [:edit, :update]

  def new
    if find_recipe_nested
      @comment = @recipe.comments.build
    else  
      @error = "Does not exist" if params[:recipe_id]
      @comment = Comment.new
    end
  end

  def index
    if find_recipe_nested
      @comments = @recipe.comments
    else
      @error = "Does not exist" if params[:recipe_id]
      @comments = Comment.all 
    end
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:message] = "Comment succefully added"
      redirect_to comments_path
    else
      render :new
    end
  end
  
  def show 
  end
  
  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:message] = "Comment successfully updated"
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if current_user
      @comment.destroy
      flash[:message] = "Comment successfully deleted"
      redirect_to recipe_path
    else
      render :show
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :recipe_id)
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
    if !@comment
      flash[:message] = "Comment was not found"
      redirect_to comments_path
    end
  end

  def redirect_if_not_comment_author
    redirect_to comments_path if @comment.user != current_user
  end

  def find_recipe_nested #if nested and finds the recipe
    params[:recipe_id] && @recipe = Recipe.find_by_id(params[:recipe_id]) #if nested and then setting a value and checking if @recipe is nill or something 
  end

end
