class CreateSocieties < ActiveRecord::Migration[6.0]
  def change
    create_table :societies do |t|
      t.string :name, null: false
      t.text :description
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :owner_user_login, null: false

      t.timestamps
    end
    add_foreign_key :societies, :users, column: :owner_user_login, primary_key: "login"

    create_table :society_phones, primary_key: [:society_id, :phone] do |t|
      t.integer :society_id
      t.string :phone
    end
    add_foreign_key :society_phones, :societies, column: :society_id, primary_key: "id"

    create_table :society_ratings, primary_key: [:society_id, :user_login] do |t|
      t.integer :society_id
      t.string :user_login
      t.text :comment
    end
    add_foreign_key :society_ratings, :societies, column: :society_id, primary_key: "id"
  end
end
