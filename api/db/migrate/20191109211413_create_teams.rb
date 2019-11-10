class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams, id: false do |t|
      t.string :initials, primary_key: true, uniqueness: {case_sensitive: false}
      t.string :name, null: false
      t.string :avatar
      t.string :owner_user_login, null: false

      t.timestamps
    end
    add_foreign_key :teams, :users, column: :owner_user_login, primary_key: "login"

    create_table :team_subscriptions, primary_key: [:team_initials, :user_login] do |t|
      t.string :team_initials
      t.string :user_login
      t.string :role
      t.boolean :accepted
      t.boolean :banned, null: false, default: false

      t.timestamps

    end
    add_foreign_key :team_subscriptions, :teams, column: :team_initials, primary_key: "initials"
    add_foreign_key :team_subscriptions, :users, column: :user_login, primary_key: "login"

  end
end


