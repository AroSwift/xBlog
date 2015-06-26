class UsersController < ApplicationController
include UsersHelper


def signup
   @signup_user = User.new
end 

  # Create User
  def create
    @username = params[:username]
    @password = params[:password]
    @confirm_password = params[:confirm_password]
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

            # Create Session
            session[:current_user_id] = user.id
            session[:current_username] = user.username
            session[:current_password] = user.password

            # If this is the first user
            if @firstu == 'true' then
              admin_user = User.find_by(username: @username, password: @password)
              admin_user.admin = true
              admin_user.superadmin = true
              admin_user.save(user_params)
              session[:admin] = true
              session[:super_admin] = true
            end

            redirect_to home_path(:display => 'Your account has been successfully created') unless admin?
            redirect_to admin_home_path(:display => 'Your account has been successfully created') unless !admin?

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
    params.require(:signup).permit(:username, :password, :admin, :superadmin, :id, :created_at, :updated_at)
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
