class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter CASClient::Frameworks::Rails::Filter
  
  def current_user
	  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
	  	rescue ActiveRecord::RecordNotFound # fixed lost record
	end
end
