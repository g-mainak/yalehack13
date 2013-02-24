class StaticPagesController < ApplicationController
	
	def home
		@projects = Project.all
		@username = session[:cas_user]
	end
end
