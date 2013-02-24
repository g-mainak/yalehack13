class Project < ActiveRecord::Base
	has_many :comments
	

	attr_accessible :project_name, :founder_name, :looking_for, :description, :rating, :consider, :photo

end
