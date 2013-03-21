class UserVerificationToken < ActiveRecord::Base
  	#attr_accessible :confirmed, :email, :token, :user_id, :verificaton_type
  	attr_accessible :email, :verification_type
  	belongs_to :user

  	validates :email, presence: true
  	validates :verification_type, presence: true

    before_create { generate_token(:token) }
  	after_create do
  		#Confirm the previous tokens of the same verification type 
  		UserVerificationToken.update_all 'confirmed = 1', ['user_id = ? and verification_type = ? and id != ?', self.user_id, self.verification_type, self.id ]
  	end 

  	def self.confirmed
  		where(confirmed: false)
  	end

  	def self.expires
  		2.hours.ago
  	end

  	def self.expired(token) 
  		exp = UserVerificationToken.where('created_at < ? and token = ?', expires, token)
      return exp.blank? ? false : true
  	end

    def self.used?(token)
      is_used = UserVerificationToken.where('confirmed = 1 and token = ?', token)
      return is_used.blank? ? false : true 
    end

    def generate_token(col)
        self[col] = SecureRandom.urlsafe_base64
    end

    def self.token_valid(token, type)
    	return unless token.present?
    	token = UserVerificationToken.where("token = ? and verification_type = ? and created_at > ? and confirmed = 0", token, type, UserVerificationToken.expires).includes(:user).first
    	user = token.user
    end

    def self.update_token(token, type)
      UserVerificationToken.update_all 'confirmed = 1', ['token = ? and verification_type = ?', token, type]
    end

end
