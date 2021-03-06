class SessionsController < ApplicationController
	skip_before_filter :signed_in_user

	def new
	end

	def create
		auth_facebook = request.env["omniauth.auth"]
		user = User.find_by_provider_and_uid(auth_facebook["provider"], auth_facebook["uid"]) || User.create_with_omniauth(auth_facebook)
		session[:user_id] = user.id # CHANGE THIS!
		redirect_to user, :notice => "Signed in!"
	end

	# def create
	# 	auth_hash = request.env['omniauth.auth']
	# 	if session[:user_id]
	# 		# Means our user is signed in. Add the authorization to the user
	# 	    User.find(session[:user_id]).add_provider(auth_hash)
	# 	    User.find(session[:user_id]).update_attribute(auth_hash.info.name)
	# 	    if auth_hash.info.email
	# 	    	User.find(session[:user_id]).update_attribute(:email, auth_hash.info.email)
	# 	    end
	# 	    User.find(session[:user_id]).save!
	# 	    redirect_to root_url, :alert => "You can now login using #{auth_hash["provider"].capitalize} too!"
	# 	else
	# 	    # Log him in or sign him up
	# 	    auth = Authorization.find_or_create(auth_hash)
	# 	    # Create the session
	# 	    session[:user_id] = auth.user.id
	# 	    auth.user.netid = session[:cas_user]
	# 	    if auth_hash.info.email
	# 	    	auth.user.email = auth_hash.info.email
	# 	    end
	# 	    auth.user.save!
	# 	    redirect_to root_url, :alert => "Welcome #{auth.user.name}!"		#root_url
	# 	end
	# end

	def failure
		redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "Signed out!"
	end

	def promote
    Project.increment_counter(:promote, params[:id])
  end
end
