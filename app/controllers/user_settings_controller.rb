class UserSettingsController < ApplicationController
	before_filter :signed_out_user, only: [:account]
	before_filter :signed_in_user, only: [:password_reset_request]
	before_filter :email_verified?, only: [:account]
	
	def account
		render 'account'
	end
	def notifications
		render 'notifications'
	end
	def social
		render 'social'
	end
	def profile
		render 'profile'
	end

	############# PASSWORD ###################

	def confirm_password_reset
		token = params[:pass_reset]
		if UserVerificationToken.expired(token)
			redirect_to recover_password_path :notice => "Password reset has expired"
		elsif UserVerificationToken.used?(token)
			redirect_to recover_password_path :notice => "Password reset has been used"
		else
			@user = UserVerificationToken.token_valid(token,"password")
    		render 'reset_password' if @user
		end
  	end
	

	def password_reset_request
		    user = User.find_by_email(params[:email])
		    user.send_password_reset if user
		    redirect_to root_url, :notice => "If the email is registered with us, you will 
		    receive an email with further instructions on recovering your password."
	end

	def password_reset
		new_pass = params[:user][:password]
		token = params[:format]
		type = "password"

		@user = UserVerificationToken.token_valid(token,type)

		if @user.authenticate(new_pass)
			flash[:error] = "You need to choose a different password"	
			redirect_to :controller => 'user_settings', :action => 'confirm_password_reset', :pass_reset => token
		elsif @user.update_attributes(password: new_pass)
			UserVerificationToken.update_token(token,type)
			redirect_to root_url, :notice => "Password has been reset"
		else
			render 'reset_password'
		end

	end
	############# END PASSWORD ###############

	############# EMAIL ######################

	def confirm_email
		token = params[:confirm]
		type = 'email'
		if UserVerificationToken.expired(token)
			flash[:sucess] = "Email token has expired"
    		redirect_to root_path 
		elsif UserVerificationToken.used?(token)
			flash[:sucess] = "Email token has been used"
    		redirect_to root_path 
		elsif @user = UserVerificationToken.token_valid(token,type)
    		@user.update_email_status if @user
    		UserVerificationToken.update_token(token, type)
    		email_verified @user
    		flash[:sucess] = "Your account has been verified"
    		redirect_to root_path 
    	else
    		flash[:sucess] = "Token not found"
    		redirect_to root_path 	
		end
	end

	############# END EMAIL ###################




end
