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
    # @password_confirmation = params[:user][:password_confirmation]

    @user = User.new(user_params)
    @user.username = params[:user][:username]
    @user.password = params[:user][:password]


    # Checks for errors
    if @user.valid? then
      @user.save(user_params)

      # Create Session
      session[:current_user_id] = @user.id
      session[:current_username] = @user.username
      session[:current_password] = @user.password

      # If this is the first user
      if first_user? then
        admin_user = User.find_by(username: @username)
        admin_user.admin = true
        admin_user.superadmin = true
        admin_user.save(user_params)
        session[:admin] = true
        session[:super_admin] = true
      end

      redirect_to :root unless admin?
      redirect_to :admin_home unless !admin?
    else
      flash[:username] = @username
      flash[:password] = @password

      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end


  # Login User
  def login_user
    @username = params[:login][:username]
    @password = params[:login][:password]
    flash[:username] = @username
    flash[:password] = @password

    user = User.new
    user.username = @username
    user.password = @password
    user.valid?

    # Checks for errors
    if user.errors.empty? then
      dbusername = User.find_by(username: @username)
      dbpassword = User.find_by(password: @password)

      if !dbusername.nil? && !dbpassword.nil? then

        session[:current_user_id] = dbusername.id
        session[:current_username] = dbusername.username
        session[:current_password] = dbusername.password

        # If user is admin
        astatus = User.find_by_username(@username)
        if astatus.admin == true then

          session[:admin] = true
          if astatus.superadmin == true then
            session[:super_admin] = true
          end

          redirect_to :admin_home

        else
          # If user is not admin
          redirect_to :root
        end

      else
        redirect_to login_path(:display => 'The username and password do not match')
      end
    else
      redirect_to login_path(:errors => user.errors.full_messages)
    end
  end


  # Logout User
  def logout 
    @_current_user = session[:current_user_id] = nil
    @_current_user = session[:current_username] = nil 
    @_current_user = session[:current_password] = nil      
    @_current_user = session[:admin] = nil   
    @_current_user = session[:super_admin] = nil  
    redirect_to root_path(:display => 'Logout Sucessful')
  end


  private
  # What fields can be saved to Database
  def user_params
    params.require(:user).permit(:username, :password, :admin, :superadmin)
  end

end
