module UsersHelper

  # Checks if super admin
  def super_admin?
    cookies.signed[:current_user_id].present? && cookies.signed[:current_username].present? && cookies.signed[:current_password].present? && cookies.signed[:admin] == "true" && cookies.signed[:super_admin] == "true"
  end

	# Checks if logged in and admin
	def admin?
    cookies.signed[:current_user_id].present? && cookies.signed[:current_username].present? && cookies.signed[:current_password].present? && cookies.signed[:admin] == "true"
  end

  # Checks if logged in
  def logged_in?
    cookies.signed[:current_user_id].present? && cookies.signed[:current_username].present? && cookies.signed[:current_password].present?
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
