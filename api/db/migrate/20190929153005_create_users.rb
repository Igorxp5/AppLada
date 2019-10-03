class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: false do |t|
      t.string :login, primary_key: true, uniqueness: {case_sensitive: false}
      t.string :password_digest
      t.string :name
      t.string :email, unique: true
      t.string :gender
      t.date :birthday

      t.timestamps
    end
  end
end
