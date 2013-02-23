class SessionsController < ApplicationController
  def new
	  redirect_to '/auth/:provider'
	end

  def create
	  auth_facebook = request.env["omniauth.auth"]
	  user = User.find_by_provider_and_uid(auth_facebook["provider"], auth_facebook["uid"]) || User.create_with_omniauth(auth_facebook)

	  session[:user_id] = user.id
		redirect_to root_url, :alert => "Signed in!"		#root_url
	end

  def failure
	  redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
	end

  def destroy
	  reset_session
	  redirect_to root_url, :notice => 'Signed out!'
	end

	def find_by_provider_and_uid(provider, uid)
	  where(provider: provider, uid: uid).first
	end

end
