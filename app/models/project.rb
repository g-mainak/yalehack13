class Project < ActiveRecord::Base
	has_many :comments
	attr_accessible :project_name, :founder_name, :looking_for, 
	:description, :rating, :consider, :photo, :tag_list
	acts_as_taggable

	def self.search(search)
		puts "+++++"
		puts search
		puts "-----"
		if search
			a = ["project_name", "founder_name", "looking_for", "description"]
			res = []
			for i in a
				res = res + find(:all, :conditions => ["#{i} LIKE ?", "%#{search}%"])
			end
			res.uniq
		else
			find(:all)
		end
	end
end
