class User < ActiveRecord::Base
	has_secure_password
	validates :email, uniqueness: true
	validates :name, presence: true
	has_many :events
 	has_many :tickets
end
