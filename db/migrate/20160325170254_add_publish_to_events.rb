class AddPublishToEvents < ActiveRecord::Migration
  def change
    add_column :events, :user_id, :integer
    add_column :events, :published, :boolean
  end
end
