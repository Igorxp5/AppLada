class CreateUserFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_followers, primary_key: [:user_login, :follower_user_login] do |t|
      t.string :user_login, null: false
      t.string :follower_user_login, null: false

      t.timestamps
    end
    add_foreign_key :user_followers, :users, column: :user_login, primary_key: "login", on_delete: :cascade
    add_foreign_key :user_followers, :users, column: :follower_user_login, primary_key: "login", on_delete: :cascade
  end
end
