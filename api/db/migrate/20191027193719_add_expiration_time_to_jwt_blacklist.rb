class AddExpirationTimeToJwtBlacklist < ActiveRecord::Migration[6.0]
  def change
  	add_column :jwt_blacklist, :exp, :datetime, null: false
  end
end
