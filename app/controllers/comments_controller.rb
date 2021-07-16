class CommentsController < ApplicationController
  
  private

  def comment_params
    params.require(:comment).permit(:content, :recipe_id
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

end
