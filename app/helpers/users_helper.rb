module UsersHelper

	def admin?
    session[:admin] == true
  end

  def logged_in?
    session[:current_user_id].present? && session[:current_username].present?
  end

end
