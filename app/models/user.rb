class User < ActiveRecord::Base
<<<<<<< HEAD
	has_many :comments

  def self.create_with_omniauth(auth)
	  create! do |user|
	    user.provider = auth['provider']
	    user.uid = auth['uid']
	    if auth['info']
	       user.name = auth['info']['name'] || ""
	    end
	  end
	end
=======
	has_many :authorizations
	attr_accessible :name, :netid, :bio, :skills

	def add_provider(auth_hash)
  # Check if the provider already exists, so we don't add it twice
  unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  	Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
  end
end
>>>>>>> c06343a3ec123902505f36ffb2de1cd08e714aeb
end

