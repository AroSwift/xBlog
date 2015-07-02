module UsersHelper

  # Checks if super admin
  def super_admin?
    session[:current_user_id].present? && session[:current_username].present? && session[:current_password].present? && session[:admin] == true && session[:super_admin] == true
  end

	# Checks if logged in and admin
	def admin?
    session[:current_user_id].present? && session[:current_username].present? && session[:current_password].present? && session[:admin] == true
  end

  # Checks if logged in
  def logged_in?
    session[:current_user_id].present? && session[:current_username].present? && session[:current_password].present?
  end

  # Checks if password is equal to confirm password
  def equal_password?
    params[:user][:password] == params[:user][:password_confirmation]
  end
  
  # Checks if first user
  def first_user?
    User.count.zero? 
  end
  
end
