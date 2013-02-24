class StaticPagesController < ApplicationController
	
	def home
		@username = session[:cas_user]
	end

end
