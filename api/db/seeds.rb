# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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