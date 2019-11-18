class AddAvatarAndLevelToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatar, :string
    add_column :users, :level, :integer, :default => 1, :null => false
  end
end
