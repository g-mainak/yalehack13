class Comment < ActiveRecord::Base
	belongs_to :project
  attr_accessible :text, :votes, :project_id
end
