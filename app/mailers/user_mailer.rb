class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def signup_confirmation(token, user)
    @user = user
    @token = token

    mail to: user.email, subject: "Sign Up Confirmation"
  end

  def password_reset(user)
  	@user = user

  	mail to: user.email, subject: "Password Reset"
  end
end
