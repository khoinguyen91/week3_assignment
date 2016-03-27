require 'rails_helper'

RSpec.describe Category, type: :model do
  context "validations" do
  	it "check for presence of name" do
  		category = Category.new	
  		expect(category.save).to eq false
  	end
  end
end
