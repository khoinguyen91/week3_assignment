class User < ActiveRecord::Base
	has_secure_password
	validates :email, uniqueness: true, presence: true
	validates :name, presence: true
	validates :password, length: { in: 3..20 }
	has_many :events
 	has_many :tickets
end
