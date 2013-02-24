class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  helper_method :current_user
  
  before_filter CASClient::Frameworks::Rails::Filter
  
  def current_user
	  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
	  	rescue ActiveRecord::RecordNotFound # fixed lost record
	end

	def promote
    Project.increment_counter(:rating, params[:id])
  end
end
