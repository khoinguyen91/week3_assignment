class User < ActiveRecord::Base
	has_secure_password
	validates :email, uniqueness: true, presence: true
	validates :name, presence: true
	validates :password, length: { in: 3..20 }
	has_many :events
	has_many :tickets
	def self.from_omniauth(auth)
		where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
			user.provider = auth.provider
			user.email = auth.uid
			user.name = auth.info.name
			user.oauth_token = auth.credentials.token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			user.save!
		end
	end
end
