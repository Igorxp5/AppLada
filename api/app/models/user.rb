class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

	# has_secure_password
	validates :email, presence: true, uniqueness: {case_sensitive: false}
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :login, presence: true, uniqueness: {case_sensitive: false}
	validates :name, presence: true, format: {with: /\A[\p{L} ]+\z/, message: 'can have only letters'}
	validates :birthday, presence: true
	validates :gender, presence: true

  validates_each :birthday do |record, attr, value|
    unless value.nil?
      date = Date.strptime(value, '%d/%m/%Y')
      record.errors.add(attr, "can't be in the future") if date >= Time.now.to_date
    end
  end
  validates_each :gender do |record, attr, value|
    record.errors.add(attr, "must be 'M', 'F', or 'O'") unless ['M', 'F', 'O'].include? value
  end

  def as_json(*)
    {
     login: login, name: name, avatar: avatar, 
     email: email, birthday: birthday, level: level,
     gender: gender, registred_date: registred_date,
     followers: followers.length, following: following.length
    }
  end

  def birthday
    super.strftime("%d/%m/%Y")
  end

  def registred_date
    self.created_at.to_time.to_i
  end

  def followers
    UserFollower.where(user_login: login)
  end

  def following
    UserFollower.where(follower_user_login: login)
  end

  def jwt_payload
    {login: login}
  end

  def total_played_tournaments
    subscriptions = TeamSubscription.where(user_login: login, accepted: true, banned: false)
    played_tournaments = subscriptions.collect do |subscription|
      tournament_sub = TournamentSubscription.find_by(team_initials: subscription.team_initials)
      if tournament_sub
        tournament_sub.tournament_id
      end
    end
    # Remover torneios nulos
    played_tournaments = played_tournaments.select {|tournament| tournament}
    played_tournaments.uniq.size
  end

  def total_win_tournaments
    teams = TeamSubscription.where(user_login: login, accepted: true, banned: false).collect do |team|
      team.team_initials
    end
    subscriptions = TournamentSubscription.where(team_initials: teams, accepted: true).collect do |subscription|
      subscription.id
    end
    TournamentRanking.where(tournament_subscription_id: subscriptions, ranking_position: 1).size
  end

  def last_played_tournament
    teams = TeamSubscription.where(user_login: login, accepted: true, banned: false).collect do |team|
      team.team_initials
    end
    subs_id = TournamentSubscription.where(team_initials: teams, accepted: true).collect {|subs| subs.id}
    ranking = TournamentRanking.where(tournament_subscription_id: subs_id).order(updated_at: :desc)
    ranking.first.tournament_id if ranking.first
  end

  def games
    GameParticipant.where(user_login: login, will_go: true).order(updated_at: :desc).collect do |subs|
      subs.game
    end
  end

  def teams
    teams = TeamSubscription.where(user_login: login, accepted: true, banned: false).order(joined_date: :desc).collect do |team|
      team.team_initials
    end
    teams = teams.collect! do |team|
      Team.find_by(initials: team)
    end
  end

  def feeds(offset=0, limit=20)
    Feed.where(user_login: login).offset(offset).limit(limit).order(created_at: :desc)
  end

  def societies
    Society.where(owner_user_login: login)
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = (conditions.delete(:login) || '').strip.downcase
    email = (conditions.delete(:email) || '').strip.downcase
    where(conditions).where(["login = :login OR email = :email", {login: login, email: email}]).first
  end

end
