class SessionsController < ApplicationController
	def new
		redirect_to '/auth/:provider'
	end

	def create
		auth_hash = request.env['omniauth.auth']
		render :xml => auth_hash
		return
		if session[:user_id]
		    # Means our user is signed in. Add the authorization to the user
		    User.find(session[:user_id]).add_provider(auth_hash)
		    redirect_to root_url, :alert => "You can now login using #{auth_hash["provider"].capitalize} too!"
		else
		    # Log him in or sign him up
		    auth = Authorization.find_or_create(auth_hash)
		    # Create the session
		    session[:user_id] = auth.user.id
		    redirect_to root_url, :alert => "Welcome #{auth.user.name}!"		#root_url
		end
	end

	def failure
		redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
	end

	def destroy
		reset_session
		redirect_to root_url, :notice => 'Signed out!'
	end

end
