class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
  end

  def create

    @username = params[:users][:username]
    @password = params[:users][:password]
    @confirm_password = params[:users][:confirm_password]

# Check if paramaters are met
if @username.length < 5 then

      flash[:error] = 'Your username must be at least 5 characters'
      redirect_to :back
    elsif @username.length > 12 then

      flash[:error] = 'Your username must not be greater than 12 characters'
      redirect_to :back
    elsif @password.length < 8 then

      flash[:error] = 'Your password must be at least 8 characters'
      redirect_to :back
    elsif @password.length > 20 then

      flash[:error] = 'Your password must not be greater than 20 characters'
      redirect_to :back
     elsif @confirm_password != @password then

      flash[:error] = "Your passwords don't match"
      redirect_to :back 

    else
      # DATABASE STUFF AFTER ALL CONDITIONS MEET

    cname = User.find_by(username: @username)
    if cname.nil? then

        user = User.create(user_params)
        if(request.post? && user.save)
          flash[:error] = 'Account created.'
            redirect_to :home


          # Create Session
            session[:current_user_id] = user.id
            session[:current_username] = user.username


        else
          flash[:error] = 'Account not created. Try again.'
          redirect_to :signup
        end

    else
        flash[:error] = 'That username already exists'
        redirect_to :signup
    end
    end

end

  def user_params
    params.require(:users).permit(:username, :password)
  end

 def destroy
    # Logout
    @_current_user = session[:current_user_id] = nil
    @_current_user = session[:current_username] = nil    
    redirect_to :home
  end

end
