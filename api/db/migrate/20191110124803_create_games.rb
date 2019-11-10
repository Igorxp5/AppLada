class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :title, null: false
      t.text :description
      t.string :latitude, null: false
      t.string :longitude, null: false
      t.timestamp :start_date, null: false
      t.timestamp :end_date, null: false
      t.integer :limit_participants
      t.string :state, null: false, default: "on_hold"
      t.string :owner_user_login, null: false

      t.timestamps
    end
    add_foreign_key :games, :users, column: :owner_user_login, primary_key: "login", on_delete: :cascade
    
    create_table :game_participants, primary_key: [:game_id, :user_login] do |t|
      t.integer :game_id
      t.string :user_login
      t.boolean :will_go, null: false, default: true

      t.timestamps
    end
    add_foreign_key :game_participants, :games, column: :game_id, primary_key: "id", on_delete: :cascade
    add_foreign_key :game_participants, :users, column: :user_login, primary_key: "login", on_delete: :cascade

  end
end
