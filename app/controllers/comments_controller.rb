class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
  end

  def new
  	@comment = Comment.new
  end

  def create #this is broken
    @comment = @project.comments.build(params[:comment])
    if @comment.save
      flash[:success] = "comment created!"
      redirect_to :root
    else
		flash[:error] = "Sorry! Something went wrong."
      redirect_to :root
    end
  end
end
