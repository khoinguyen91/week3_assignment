class AddQuantityToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :name, :string
    add_column :orders, :description, :text
    add_column :orders, :quantity, :integer
    add_column :orders, :total, :integer
    add_column :orders, :email, :string
  end
end
