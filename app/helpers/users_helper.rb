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

  def first_user?
  	User.count.zero? 
  end

  def update_user_params_exist?
    params[:username].present? && params[:password].present? && params[:id].present?
  end

  def delete_user_params_exist?
    params[:dusername].present? && params[:dpassword].present? && params[:dadmin].present?
  end
  
end
