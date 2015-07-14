class RequestsController < ApplicationController
include UsersHelper


  def new
     @request = Request.new
  end 

  def edit
    @request = Request.find(params[:id])
  end

  def show
    @request = Request.all
  end


  # Request to become admin
  def create
    prev_request = Request.find_by_username(cookies.signed[:current_username])

    # If user has already submitted a request
    if !prev_request.nil? then
      flash[:error] = 'You have already submitted a request'
      redirect_to :back
      return
    end

    r = Request.new
    r.username = cookies.signed[:current_username]
    r.password = cookies.signed[:current_password]
    r.user_id = cookies.signed[:current_user_id]

    # Check for errors
    if r.valid? then
      r.save(request_params)
      flash[:error] = 'Your request has been submitted'
      redirect_to account_user_path(cookies.signed[:current_user_id])
    else # If validation errors
      flash[:errors] = r.errors.full_messages
      redirect_to :back
    end
  end


  # Accept request for norm user to become admin
  def update
    user = User.find(params[:id])
    user.admin = true
    user.save(user_params)

    Request.where(:user_id => params[:id]).destroy_all unless !super_admin?
    Request.where(:user_id => params[:id]).update_all(status: true, accepted_by: cookies.signed[:current_username]) unless super_admin?

    flash[:error] = "#{user.username} is now an administrator"
    redirect_to :admin_users
  end


  # reject request
  def destroy
    user = User.find(params[:id])

    # If super admin is rejecting for final time
    if params[:adminreject] == 'true' then
      User.where(:id => params[:id]).update_all(admin: false)
      Request.where(:user_id => params[:id]).destroy_all
    end

    # if normal admin is rejecting
    if params[:reject] == 'true' then
      Request.where(:user_id => params[:id]).update_all(status: true, rejected_by: cookies.signed[:current_username])
    end  

    flash[:error] = "#{user.username} has been rejected administratorship"
    redirect_to :admin_users
  end


  private
  # What fields can be saved to Database
  def request_params
    params.permit(:username, :password, :user_id, :status, :accepted_by, :rejected_by)
  end

  def user_params
    params.permit(:admin)
  end

end
