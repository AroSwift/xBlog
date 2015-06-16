module UsersHelper

	# Checks if logged in and admin
	def admin?
    session[:current_user_id].present? && session[:current_username].present? && session[:admin] == true
  end

  # Checks if logged in
  def logged_in?
    session[:current_user_id].present? && session[:current_username].present?
  end

end
