class SessionsController < ApplicationController
  def new
    @user = User.new
    @password = Password.new(:password=>params[:password])
  end

  def show
    @user = User.find_by_id(params[id])
  end

  def create
    @username = params[:login][:username]
    @password = params[:login][:password]


# Check if paramaters are met
if @username.empty? then

      flash[:error] = "Please enter a username"
      redirect_to :back 
    elsif @password.empty? then

      flash[:error] = "Please enter a password"
      redirect_to :back 

    else
        # DATABASE AND SESSION STUFF AFTER ALL CONDITIONS MEET
        dbuser = User.find_by(username: @username, password: @password)
        if dbuser.nil? then
      
            session[:current_user_id] = user.id
            session[:current_username] = user.username

        redirect_to :home
        else
        flash[:error] = "Your username and password did not match. Please try again."
        redirect_to :back 
        end
end
end


 def destroy
    # Logout
    @_current_user = session[:current_user_id] = nil
    redirect_to :home
  end
end
