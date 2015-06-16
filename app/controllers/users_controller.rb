class UsersController < ApplicationController

  # Create User
  def create
    @username = params[:signup][:username]
    @password = params[:signup][:password]
    @confirm_password = params[:signup][:confirm_password]
    flash[:username] = @username
    flash[:password] = @password


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
            redirect_to home_path(:display => 'Your account has been successfully created')

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

        astatus = User.find_by_username(@username)

        # If user is admin
        if astatus.admin == true || astatus.admin == 't'then

          session[:current_user_id] = dbusername.id
          session[:current_username] = dbusername.username
          session[:current_pasword] = dbpassword.password
          session[:admin] = true
          redirect_to :admin_home

        else
          # If user is not admin
          session[:current_user_id] = dbusername.id
          session[:current_username] = dbusername.username
          session[:current_pasword] = dbpassword.password
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
    params.require(:signup).permit(:username, :password, :id, :admin)
  end

  # Logout User
 def logout
    @_current_user = session[:current_user_id] = nil
    @_current_user = session[:current_username] = nil    
    @_current_user = session[:current_pasword] = nil  
    @_current_user = session[:admin] = nil    
    redirect_to :home
  end

end
