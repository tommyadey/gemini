class SessionsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create]

  def new
    render :layout => "signedout_layout"
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      params[:session][:remember_me] == 1 ? sign_in(user) : sign_in_unchecked(user)
      email_verified user     
      redirect_back_or root_path
      #redirect_to root_url, :notice => "Signed In"
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
