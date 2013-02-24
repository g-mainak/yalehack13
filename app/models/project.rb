class Project < ActiveRecord::Base
	has_many :comments
	
<<<<<<< HEAD
	attr_accessible :project_name, :founder_name, :looking_for, :description, :rating, :consider, :photo

=======
	attr_accessible :project_name, :founder_name, 
	:looking_for, :description, :rating, :consider
>>>>>>> 01cce2d38eb53f258950e893a881d4c783b31db3
end
