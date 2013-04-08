class UsersController < ApplicationController
  before_filter :signed_out_user, only: [:index]
  before_filter :signed_in_user, only: [:new, :create, :recover_password]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @statuses = @user.statuses
  end

  def new
    @user = User.new
    render :layout => "signedout_layout"
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      email_verified @user
      flash[:success] = "Welcome To Project Gemini"
      #later on you might want to redirect to a page for the user to fill in some info 7.41
      redirect_to root_url
    else
      render 'new'
    end
  end

  def recover_password
    render 'recover_password', :layout => "signedout_layout"
  end    


end
