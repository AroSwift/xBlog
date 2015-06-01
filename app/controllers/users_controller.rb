class UsersController < ApplicationController
  def new
  	@users = User.new
  end

  def create
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])

    else
      flash.now[:error] = 'Invalid username/password combination'
      render 'new'
    end
  end
end
