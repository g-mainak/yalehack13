class Project < ActiveRecord::Base
	has_many :comments
	# has_many :taggings
 	#  has_many :tags, through: :taggings
	attr_accessible :project_name, :founder_name, :looking_for, 
	:description, :rating, :consider, :photo, :tag_list, :contact
	acts_as_taggable

	validates_format_of :contact,
                    :with => /[-!#$&'*+\/=?`{|}~.\w]+@[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])*(\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])*)+$/,
                    :message => 'invalid e-mail'

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

 # def self.tagged_with(name)
 #    Tag.find_by_name!(name).articles
 #  end

 #  def self.tag_counts
 #    Tag.select("tags.*, count(taggings.tag_id) as count").
 #      joins(:taggings).group("taggings.tag_id")
 #  end
  
 #  def tag_list
 #    tags.map(&:name).join(", ")
 #  end
  
 #  def tag_list=(names)
 #    self.tags = names.split(",").map do |n|
 #      Tag.where(name: n.strip).first_or_create!
 #    end
 #  end
end
