class RequestsController < ApplicationController
include UsersHelper


  # Request to become admin
  def request_admin
    @username = session[:current_username]
    @password = session[:current_password]
    @id = session[:current_user_id]


    req = Request.find_by(username: @username, password: @password)

    request = Request.new
    if req.nil? then
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

    else
      redirect_to account_path(:display => 'You have already submitted a request')
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

      # Make user admin
      user.save
      if super_admin? then
        Request.where(:username => @username, :password => @password).destroy_all
      else
        Request.where(:username => @username, :password => @password).update_all(status: true, accepted_by: session[:current_username])
      end


      redirect_to admin_home_path(:display => "#{@username} is now an administrator")
    else
      redirect_to admin_users_path(:display => "#{@username} is NOT an administrator. Please try again.")
    end
  end


  # accept or reject request
  def delete_request
    @username = params[:username]
    @password = params[:password]
    @id = params[:id]
    @adminreject = params[:adminreject]
    @reject = params[:reject]

    # If super admin is rejecting for final time
    if @adminreject == 'true' then
      User.where(:username => @username, :password => @password).update_all(admin: false)
      Request.where(:username => @username, :password => @password).destroy_all
    end

    # if normal admin is rejecting
    if @reject = 'true' then
      Request.where(:username => @username, :password => @password).update_all(status: true, rejected_by: session[:current_username])
    end  

    redirect_to admin_users_path(:display => "The request for #{@username} to become an administrator was rejected")
  end


  # What fields can be saved to Database
  def request_params
    params.permit(:username, :password, :user_id, :status)
  end

end
