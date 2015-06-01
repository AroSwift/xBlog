class UsersController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:user][:username].downcase)
    if user && user.authenticate(params[:user][:password])
      # Log the user in and redirect to the user's show page.
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end
