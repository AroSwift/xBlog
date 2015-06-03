class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def show
  end

  def create
    @lusername = params[:login][:lusername]
    @lpassword = params[:login][:lpassword]


# Check if paramaters are met
if @lusername.empty? then

      flash[:error] = "Please enter a username"
      redirect_to :back 
    elsif @lpassword.empty? then

      flash[:error] = "Please enter a password"
      redirect_to :back 

    else
        # DATABASE AND SESSION STUFF AFTER ALL CONDITIONS MEET
        #dbuser = User.find_by(username: @username, password: @password)
        dbusername = User.find_by(username: @lusername)
        dbpassword = User.find_by(password: @lpassword)
        if !dbusername.nil? && !dbpassword.nil? then
      
            session[:current_user_id] = dbusername.id
            session[:current_username] = dbusername.username

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
    @_current_user = session[:current_username] = nil    
    redirect_to :home
  end
end
