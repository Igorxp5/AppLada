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
     followers: followers, following: following
    }
  end

  def birthday
    super.strftime("%d/%m/%Y")
  end

  def registred_date
    self.created_at.to_time.to_i
  end

  def followers
    UserFollower.where(user_login: login).length
  end

  def following
    UserFollower.where(follower_user_login: login).length
  end

  def jwt_payload
    {login: login}
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = (conditions.delete(:login) || '').strip.downcase
    email = (conditions.delete(:email) || '').strip.downcase
    where(conditions).where(["login = :login OR email = :email", {login: login, email: email}]).first
  end

end
