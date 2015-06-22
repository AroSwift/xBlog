class RequestsController < ApplicationController
include UsersHelper


  # Request to become admin
  def request_admin
    @username = session[:current_username]
    @password = session[:current_password]
    @id = session[:current_user_id]

    request = Request.new
    request.username = @username
    request.password = @password
    request.user_id = @id
    request.valid?

    # Check if there are errors
    if request.errors.empty? then
      request.save(request_params)
      redirect_to account_path(:display => 'Your request has been submitted')
    else
      redirect_to account_path(:errors => request.errors.full_messages)
    end
  end


  # Accept request for norm user to become admin
  def accept_request
    @username = params[:username]
    @password = params[:password]

    user = User.find_by(username: @username)
    user.admin = true
    user.valid?

    # Check for errors
    if user.errors.empty? then

      # Upgrade user to admin and delete the request
      user.save
      Request.where(:username => @username, :password => @password).destroy_all
      redirect_to admin_home_path(:display => "#{@username} is now an administrator")
    else
      redirect_to admin_users_path(:display => "#{@username} is NOT an administrator. Please try again.")
    end
  end


  # Delete request for norm user to become admin
  def delete_request
    @username = params[:username]
    @password = params[:password]
    @id = params[:id]

    Request.where(:username => @username, :password => @password).destroy_all
    redirect_to admin_users_path(:display => "The request for #{@username} to become an administrator was successfully deleted")
  end


  # What fields can be saved to Database
  def request_params
    params.permit(:username, :password, :user_id, :status)
  end

end
