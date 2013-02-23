class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
  end

  def new
  	@comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(params[:comment])
    if @comment.save
      flash[:success] = "comment created!"
      redirect_to current_user
    else
		flash[:error] = "Sorry! Something went wrong."
      render new_comment_path
    end
  end
end
