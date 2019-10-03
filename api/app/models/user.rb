class User < ApplicationRecord
	has_secure_password
	validates :email, presence: true, uniqueness: true
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :login, presence: true, uniqueness: true
	validates :name, presence: true, format: {with: /\A[a-z]+\Z/i, message: 'can have only letters'}
	validates :birthday, presence: true
	validates :gender, presence: true
	validates :password,
	        length: { minimum: 8, maximum: 16 },
	        if: -> { new_record? || !password.nil? }

	validates_each :birthday do |record, attr, value|
      record.errors.add(attr, "can't be in the past") if value >= Time.now.to_date
    end
    validates_each :gender do |record, attr, value|
      record.errors.add(attr, "must be 'M', 'F', or 'O'") unless ['M', 'F', 'O'].include? value
    end

    after_initialize  :downcase_fields

    def downcase_fields
    	self.login.downcase!
    end
end
