class Comment < ActiveRecord::Base
  attr_accessible :text, :votes, :project_id
end
