class Comment < ActiveRecord::Base
<<<<<<< HEAD
	belongs_to :user
	belongs_to :project
	
=======
	belongs_to :project
>>>>>>> c06343a3ec123902505f36ffb2de1cd08e714aeb
  attr_accessible :text, :votes, :project_id
end
