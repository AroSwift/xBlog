class UsersController < ApplicationController
include UsersHelper


  def new
     @user = User.new
  end 

  def index
    @users = User.all
  end


  # Create User
  def create
    user = User.new
    user.username = params[:user][:username]
    user.password = params[:user][:password]

    # Checks for errors
    if user.valid? then
      # User first user?
      if first_user? then
        user.admin = true
        user.superadmin = true

        # Create session for super admin
        session[:admin] = true
        session[:super_admin] = true
      end

      # Save user to db
      user.save(user_params)

      # Create Session
      session[:current_user_id] = user.id
      session[:current_username] = user.username
      session[:current_password] = user.password

      redirect_to :root unless admin?
      redirect_to :admin_home unless !admin?
    else
      flash[:username] = params[:user][:username]
      flash[:password] = params[:user][:password]

      flash[:errors] = user.errors.full_messages
      redirect_to :back
    end
  end


  # Login User
  def login_user
    user = User.new
    user.username = params[:login][:username]
    user.password = params[:login][:password]

    # Check if user exists in db
    dbuser = User.find_by(username: params[:login][:username])
    
    # Checks if user exists in db
    if !dbuser.nil? then
      session[:current_user_id] = dbuser.id
      session[:current_username] = dbuser.username
      session[:current_password] = dbuser.password


      status = User.find_by_username(params[:login][:username])
      # If user is admin
      if status.admin == true then
        session[:admin] = true
      end

      # if user is super admin
      if status.superadmin == true then
        session[:super_admin] = true
      end

      redirect_to :root unless admin?
      redirect_to :admin_home unless !admin?
    else
      flash[:username] = params[:login][:username]
      flash[:password] = params[:login][:password]

      flash[:error] = 'The username and password do not match'
      redirect_to :back
    end

  end


  # Logout User
  def logout 
    # @_current_user = session[:current_user_id] = nil
    # @_current_user = session[:current_username] = nil 
    # @_current_user = session[:current_password] = nil      
    # @_current_user = session[:admin] = nil   
    # @_current_user = session[:super_admin] = nil  

    reset_session

    flash[:error] = 'Logout successful'
    redirect_to :root
  end


  private
  # What fields can be saved to Database
  def user_params
    params.require(:user).permit(:username, :password, :admin, :superadmin)
  end

end
