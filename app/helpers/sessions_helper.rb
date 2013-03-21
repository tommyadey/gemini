module SessionsHelper
  #Permanent(20yrs)-Sign in method(Sets cookie token using generated token)
  #Sets current user to user
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end
  #Temporary sign in when remember me is not checked
  def sign_in_unchecked(user)
    cookies[:remember_token] = user.remember_token
    self.current_user = user
  end

  #A user is signed in if current_user is not(that is ! ) nil
  def signed_in?
    !current_user.nil?
  end


  def signed_out_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
  end

  def signed_in_user
    if signed_in?
        store_location
        redirect_to root_path 
      end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  #defining assignment to current_user
  def current_user=(user)
    @current_user = user
  end

  #Returns the current_user(if present) or finds user by the remember token if cookie is set
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def store_location
    session[:return_to] = request.url
  end

end
