class StaticPagesController < ApplicationController
	
	def home
		@projects = Project.all
	end

end
