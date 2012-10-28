module SessionsHelper
  def sign_in(user)
    #introduces the cookies utility supplied by Rails. 
    #We can use cookies as if it were a hash; each element in the 
    #cookie is itself a hash of two elements, a value and an optional expires date
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    #||= evaluates to a short-circuit OR
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) 
  end
end
