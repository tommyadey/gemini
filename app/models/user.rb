# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  fullname        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :fullname, :password, :username
  has_many :user_verification_tokens
  has_secure_password
  before_save { |user| user.email = email.downcase }
  before_save { |user| user.username = username.downcase }
  before_create { generate_token(:remember_token) }
  after_create { send_email_confirmation }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME = /^[a-z][a-z0-9]*$/
  validates :email, presence: true, uniqueness: { case_sensitive: false }, #<- means both uniq(true) and casesen(true)
  				   format: { with: VALID_EMAIL_REGEX,  message: 'must be valid'}
  validates :fullname, presence: true, length: { maximum: 50 }
  validates :password, length: { minimum: 6 }
  validates :username, presence: true, uniqueness: { case_sensitive: false },
  					   length: { in: 2..30 }
  
  def send_password_reset
    user = self.user_verification_tokens.create(email: email, verification_type: "password")
    UserMailer.password_reset(user).deliver
  end
  def send_email_confirmation
    token = self.user_verification_tokens.create(email: email, verification_type: "email")
    UserMailer.signup_confirmation(token, self).deliver
  end
  def update_email_status
    self.email_verified = true
    self.password = :password
    save!
  end

  private
    def generate_token(col)
      begin
        self[col] = SecureRandom.urlsafe_base64
      end while User.exists?(col => self[col])
    end

    

end
