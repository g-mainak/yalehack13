class CommentsController < ApplicationController
  before_filter :signed_in_user

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

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def signed_in?
      !current_user.nil?
    end
end
