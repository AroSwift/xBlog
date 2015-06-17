class UsersController < ApplicationController

  include UsersHelper

  # Create User
  def create
    @username = params[:signup][:username]
    @password = params[:signup][:password]
    @confirm_password = params[:signup][:confirm_password]
    flash[:username] = @username
    flash[:password] = @password

    # If this is the first user
    if first_user? then
      @firstu = 'true'
    end


    user = User.new
    user.username = @username
    user.password = @password
    user.valid?

    # Checks for errors
    if user.errors.empty? then
      if @password == @confirm_password then

        cname = User.find_by(username: @username)
        if cname.nil? then

          user = User.create(user_params)
          if(request.post? && user.save)
            user.save(user_params)
            flash[:error] = 'Account created.'

            # Create Session
            session[:current_user_id] = user.id
            session[:current_username] = user.username
            session[:current_password] = user.password

            # If this is the first user
            if @firstu == 'true' then

              admin_user = User.find_by(username: @username, password: @password)
              admin_user.admin = true
              admin_user.save(user_params)
              session[:admin] = true
            end

            if admin?
              redirect_to admin_home_path(:display => 'Your account has been successfully created')
            else
              redirect_to home_path(:display => 'Your account has been successfully created')
            end

          else
            redirect_to signup_path(:errors => user.errors.full_messages)
          end

        else
          redirect_to signup_path(:display => 'Username already exists')
        end
      else
        redirect_to signup_path(:display => 'The passwords do not match')
      end
    else
      redirect_to signup_path(:errors => user.errors.full_messages)
    end
  end


  # Request to become admin
  def request_admin
    @username = session[:current_username]
    @password = session[:current_password]
    #@id = session[:current_user_id]

    request = Request.new
    request.username = @username
    request.password = @password
    request.user_id = @id
    request.valid?


    if request.errors.empty? then
      request.save(request_params)
      redirect_to account_path(:display => 'Your request has been submited')
    else
      redirect_to account_path(:errors => request.errors.full_messages)
    end
  end


  # Accept request for norm user to become admin
  def accept_request
    @username = session[:current_username]
    @password = session[:current_password]
    #@id = session[:current_user_id]

    user = User.find_by(username: @username)
    user.admin = true
    user.valid?

    # Check for errors
    if request.errors.empty? then

      # Upgrade user to admin and delete the request
      user.save(request_params)
      Request.where(:username => @username, :password => @password).destroy_all
      redirect_to admin_home_path(:display => "#{@username} is now an administrator")
    else
      redirect_to admin_users_path(:display => "Something went wrong. The user #{@username} is not an administrator")
    end
  end


  # Delete request for norm user to become admin
  def delete_request
    @username = params[:username]
    @password = params[:password]
    @id = params[:id]

    Request.where(:username => @username, :password => @password).destroy_all
    redirect_to admin_users_path(:display => "The request for #{@username} to become an administrator successfully deleted")
  end


  # Login User
  def show
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
        if astatus.admin == true || astatus.admin == 't'then

          session[:admin] = true
          redirect_to :admin_home
        else
          # If user is not admin
          redirect_to :home
        end

      else
        redirect_to login_path(:display => 'The username and password do not match')
      end
    else
      redirect_to login_path(:errors => user.errors.full_messages)
    end
  end

  # What fields can be saved to Database
  def user_params
    params.require(:signup).permit(:username, :password, :admin, :id, :created_at, :updated_at)
  end

  # What fields can be saved to Database
  def request_params
    params.permit(:username, :password, :user_id, :status)
  end

  # Logout User
 def logout
    @_current_user = session[:current_user_id] = nil
    @_current_user = session[:current_username] = nil    
    @_current_user = session[:current_password] = nil  
    @_current_user = session[:admin] = nil    
    redirect_to home_path(:display => 'Logout Sucessful')
  end

end
