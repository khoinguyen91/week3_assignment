require 'rails_helper'

RSpec.describe User, type: :model do
	context "validate" do
		it ' name presence'  do
			user = User.new(email: 'email@email.com', password:'1234')
			user.save
			error_message = "Name can't be blank"
			expect(user.errors.full_messages).to include error_message
		end
		it "unique email" do
			user = User.create!(email: 'email@email.com', password:'1234', name: 'test')
			user = User.new(email: 'email@email.com', password:'1234', name: 'test')
			user.save
			error_message = "Email has already been taken"
			expect(user.errors.full_messages).to include error_message
		end
		it ' password presence'  do
			user = User.new(email: 'email@email.com', name:'12344')
			user.save
			error_message = "Password can't be blank"
			expect(user.errors.full_messages).to include error_message
		end
		it ' email presence'  do
			user = User.new(name: 'Users name', password:'1234')
			user.save

			error_message = "Email can't be blank"
			expect(user.errors.full_messages).to include error_message
		end
		it ' minimum password length'  do
			user = User.new(email: 'email@email.com', password:'14', name: 'test')
			user.save

			error_message = "Password is too short (minimum is 3 characters)"
			expect(user.errors.full_messages).to include error_message
		end
		it ' maximum password length'  do
			user = User.new(email: 'email@email.com', password:'1dssdasdsdasadadsasfsafasfasfasf4', name: 'test')
			user.save

			error_message = "Password is too long (maximum is 20 characters)"
			expect(user.errors.full_messages).to include error_message
		end
	end
end
