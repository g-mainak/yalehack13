class StaticPagesController < ApplicationController
	
	def home
		@projects = Project.all(:limit => 3, :order => "rating DESC, created_at DESC")
		u = User.all
		puts "=============="
		puts u
		for i in u
			if i.netid == session[:cas_user]
				session[:user_id] = i.id
				return
			end
		end
		u = User.create(:netid => session[:cas_user])
		u.save!
		session[:user_id] = u.id
		puts "++++++++++++++"
		puts  u.id
	end


	def search
		@projects = Project.search(params[:search])
	end

end
