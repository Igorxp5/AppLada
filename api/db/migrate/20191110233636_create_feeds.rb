class CreateFeeds < ActiveRecord::Migration[6.0]
  def up
    create_table :feed_types, id: false do |t|
      t.string :name, primary_key: true

      t.timestamps
    end

    create_table :feed_parameters do |t|
      t.string :feed_type
      t.string :key
      t.string :value_type, null: false

      t.timestamps
    end
    add_index :feed_parameters, [:feed_type, :key], unique: true, name: 'feed_parameters_unique'
    add_foreign_key :feed_parameters, :feed_types, column: :feed_type, primary_key: "name", on_delete: :cascade

    create_table :feeds do |t|
      t.string :user_login
      t.string :feed_type

      t.timestamps
    end
    add_foreign_key :feeds, :users, column: :user_login, primary_key: "login", on_delete: :cascade
    add_foreign_key :feeds, :feed_types, column: :feed_type, primary_key: "name", on_delete: :cascade

    create_table :feed_arguments do |t|
      t.integer :feed_id
      t.integer :feed_parameter_id
      t.string :value, null: false

      t.timestamps
    end
    add_foreign_key :feed_arguments, :feeds, column: :feed_id, primary_key: "id", on_delete: :cascade
    add_foreign_key :feed_arguments, :feed_parameters, column: :feed_parameter_id, primary_key: "id", on_delete: :cascade
    
    insert_default_feed_types
  end
  
  def down
    drop_table :feed_arguments
    drop_table :feeds
    drop_table :feed_parameters
    drop_table :feed_types
  end

  def insert_default_feed_types
    FeedType.create(name: 'create_game')
    FeedParameter.create(feed_type: 'create_game', key: 'game_id', value_type: 'integer')
    
    FeedType.create(name: 'join_game')
    FeedParameter.create(feed_type: 'join_game', key: 'game_id', value_type: 'integer')

    FeedType.create(name: 'create_team')
    FeedParameter.create(feed_type: 'create_team', key: 'team_initials', value_type: 'string')
    
    FeedType.create(name: 'join_team')
    FeedParameter.create(feed_type: 'join_team', key: 'team_initials', value_type: 'string')
    
    FeedType.create(name: 'leave_team')
    FeedParameter.create(feed_type: 'leave_team', key: 'team_initials', value_type: 'string')

    FeedType.create(name: 'create_tournament')
    FeedParameter.create(feed_type: 'create_tournament', key: 'tournament_id', value_type: 'integer')
    
    FeedType.create(name: 'will_play_match_tournament')
    FeedParameter.create(feed_type: 'will_play_match_tournament', key: 'user_team_initials', value_type: 'string')
    FeedParameter.create(feed_type: 'will_play_match_tournament', key: 'against_team_initials', value_type: 'string')
    FeedParameter.create(feed_type: 'will_play_match_tournament', key: 'tournament_id', value_type: 'integer')
    FeedParameter.create(feed_type: 'will_play_match_tournament', key: 'match_order', value_type: 'integer')
    
    FeedType.create(name: 'win_match_tournament')
    FeedParameter.create(feed_type: 'win_match_tournament', key: 'user_team_initials', value_type: 'string')
    FeedParameter.create(feed_type: 'win_match_tournament', key: 'against_team_initials', value_type: 'string')
    FeedParameter.create(feed_type: 'win_match_tournament', key: 'tournament_id', value_type: 'integer')
    FeedParameter.create(feed_type: 'win_match_tournament', key: 'match_order', value_type: 'integer')
    
    FeedType.create(name: 'lose_match_tournament')
    FeedParameter.create(feed_type: 'lose_match_tournament', key: 'user_team_initials', value_type: 'string')
    FeedParameter.create(feed_type: 'lose_match_tournament', key: 'against_team_initials', value_type: 'string')
    FeedParameter.create(feed_type: 'lose_match_tournament', key: 'tournament_id', value_type: 'integer')
    FeedParameter.create(feed_type: 'lose_match_tournament', key: 'match_order', value_type: 'integer')

    FeedType.create(name: 'draw_match_tournament')
    FeedParameter.create(feed_type: 'draw_match_tournament', key: 'user_team_initials', value_type: 'string')
    FeedParameter.create(feed_type: 'draw_match_tournament', key: 'against_team_initials', value_type: 'string')
    FeedParameter.create(feed_type: 'draw_match_tournament', key: 'tournament_id', value_type: 'integer')
    FeedParameter.create(feed_type: 'draw_match_tournament', key: 'match_order', value_type: 'integer')
  end
end
