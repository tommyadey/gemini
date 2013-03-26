module UserSettingsHelper
	def email_verified(user)
		session[:email_verified] = user.email_verified
	end

	def email_verified?
		session[:email_verified]
	end
end
