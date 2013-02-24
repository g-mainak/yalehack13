class Comment < ActiveRecord::Base
	attr_accessible :text, :votes, :project_id	
  belongs_to :user
	belongs_to :project

	validates :text, :presence => true
end
