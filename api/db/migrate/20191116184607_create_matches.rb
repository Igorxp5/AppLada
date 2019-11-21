class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.integer :tournament_id
      t.integer :match_order
      t.timestamp :start_date, null: false
      t.integer :duration, null: false, default: 5400
      t.boolean :finished, null: false, default: false

      t.timestamps
    end
    add_index :matches, [:tournament_id, :match_order], unique: true
    add_foreign_key :matches, :tournaments, column: :tournament_id, primary_key: "id"

    create_table :match_participants do |t|
      t.integer :match_id, null: false
      t.integer :tournament_subscription_id, null: false

      t.timestamps
    end
    add_index :match_participants, [:match_id, :tournament_subscription_id], unique: true, name: 'match_participants_unique'
    add_foreign_key :match_participants, :matches, column: :match_id, primary_key: "id", on_delete: :cascade
    add_foreign_key :match_participants, :tournament_subscriptions, column: :tournament_subscription_id, primary_key: "id", on_delete: :cascade
    
    create_table :match_results, primary_key: [:match_id] do |t|
      t.integer :match_id
      t.integer :winner_tournament_subscription
      t.integer :looser_tournament_subscription
      t.integer :team_one_score, null: false, default: 0
      t.integer :team_two_score, null: false, default: 0
      
      t.timestamps
    end
    add_foreign_key :match_results, :matches, column: :match_id, primary_key: "id", on_delete: :cascade
    add_foreign_key :match_results, :tournament_subscriptions, column: :winner_tournament_subscription, primary_key: "id", on_delete: :cascade
    add_foreign_key :match_results, :tournament_subscriptions, column: :looser_tournament_subscription, primary_key: "id", on_delete: :cascade

  end
end
