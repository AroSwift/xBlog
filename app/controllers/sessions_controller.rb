class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @lusername = params[:login][:lusername]
    @lpassword = params[:login][:lpassword]

    flash[:lusername] = @lusername
    flash[:lpassword] = @lpassword

    user = User.new
    user.valid?

    if @lusername.empty? then
      flash.keep[:error] = "Please enter a username"
      redirect_to login_path(:errors => user.errors.full_messages)

    elsif @lpassword.empty? then
      flash[:error] = "Please enter a password"
      redirect_to login_path(:errors => user.errors.full_messages)

    else
      dbusername = User.find_by(username: @lusername)
      dbpassword = User.find_by(password: @lpassword)

      if !dbusername.nil? && !dbpassword.nil? then

        session[:current_user_id] = dbusername.id
        session[:current_username] = dbusername.username
        redirect_to :home

      else
        flash[:error] = "Your username and password did not match. Please try again."
        redirect_to :login 
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
