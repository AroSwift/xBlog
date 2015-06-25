module RequestsHelper

  def accept_request_params_exist?
  	params[:username].present? && params[:password].present?
  end

  def delete_request_params_exist?
  	params[:username].present? && params[:password].present? && params[:id].present?
  end

end