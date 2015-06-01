class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create

@username = params[:users][:username]
@password= params[:users][:password]
    if @username.empty? && @password.empty? then
      
    else
      flash.now[:error] = 'Invalid email/password combination. Please try again.'
      render 'create'
    end
  end

  def destroy
  end
end
