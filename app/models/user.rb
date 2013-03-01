class User < ActiveRecord::Base

	has_many :comments
	attr_accessible :name, :netid, :bio, :skills, :email, :uid
	

	has_many :authorizations

	def add_provider(auth_hash)
	  # Check if the provider already exists, so we don't add it twice
	  unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
	  	if auth_hash["provider"]=="twitter"
	  		st = auth_hash["uid"] + ',' + auth_hash.credentials.secret + ',' + auth_hash.credentials.token
	  		Authorization.create :user => self, :provider => auth_hash["provider"], :uid => st
	  	else
	  		Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
	  	end
	  end
	end

	def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.name = auth["info"]["name"]  
      user.remember_token = auth['credentials']['token']
      user.email = auth["info"]["email"]
      user.avatar = auth["info"]["image"]
      user.save!
    end  
  end
end

