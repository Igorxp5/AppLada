class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.integer :society_id, null: false
      t.string :title, null: false
      t.text :description
      t.timestamp :start_date, null: false
      t.timestamp :end_date
      t.timestamp :end_subscription_date, null: false
      t.float :price
      t.integer :teams_limit, null: false
      t.boolean :finished, null: false, default: false

      t.timestamps
    end
    add_index :tournaments, [:society_id, :finished], unique: true, where: 'finished = false'
    add_foreign_key :tournaments, :societies, column: :society_id, primary_key: "id", on_delete: :cascade

    create_table :tournament_rankings, primary_key: [:tournament_id, :ranking_position] do |t|
      t.integer :tournament_id
      t.integer :ranking_position
      t.string :team_initials, null: false

      t.timestamps
    end
    add_foreign_key :tournament_rankings, :tournaments, column: :tournament_id, primary_key: "id", on_delete: :cascade
    add_foreign_key :tournament_rankings, :teams, column: :team_initials, primary_key: "initials"

    create_table :tournament_subscriptions do |t|
      t.integer :tournament_id
      t.string :team_initials
      t.boolean :accepted
      t.boolean :banned, null: false, default: false
      t.timestamp :joined_date

      t.timestamps
    end
    add_foreign_key :tournament_subscriptions, :tournaments, column: :tournament_id, primary_key: "id"
    add_foreign_key :tournament_subscriptions, :teams, column: :team_initials, primary_key: "initials"

  end
end
