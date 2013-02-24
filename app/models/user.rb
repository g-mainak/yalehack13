class User < ActiveRecord::Base
	has_many :authorizations
	attr_accessible :name, :netid, :bio, :skills

	def add_provider(auth_hash)
  # Check if the provider already exists, so we don't add it twice
  unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    puts "===GGGGG======++++++++++++++++++=========="
    puts auth_hash["provider"]+auth_hash["credentials"]
  	if auth_hash["provider"]=="twitter"
  		Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]+','+auth_hash["credentials"]["token"]+','+auth_hash["credentials"]["secret"]
  	else
  		Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
  	end
  end
end
end

