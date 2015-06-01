class Users < ActiveRecord::Base

	  attr_accessible :name, :password, :password_confirmation

  def log_in(user)
    session[:user_id] = user.id
  end
	
end
