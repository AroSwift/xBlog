module UsersHelper

	# Checks if logged in and admin
	def admin?
    session[:current_user_id].present? && session[:current_username].present? && session[:current_password] && session[:admin] == true
  end

  # Checks if logged in
  def logged_in?
    session[:current_user_id].present? && session[:current_username].present? && session[:current_password]
  end

  def first_user?
  	User.count.zero? 
  end

  def first_post?
  	Post.count.zero?
  end

end
