class CreateUsers < ActiveRecord::Migration[6.0]
  def self.up
    create_table :users, id: false do |t|
      t.string :login, primary_key: true
      t.string :password_digest
      t.string :name
      t.string :email, unique: true
      t.string :gender
      t.date :birthday

      t.timestamps
    end
  end

  def self.down
  	drop_table :users
  end
end
