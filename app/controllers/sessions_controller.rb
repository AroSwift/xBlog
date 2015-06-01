class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(session: params[:session][:username])
    if user && user.authenticate(params[:session][:password])

    else
      flash.now[:error] = 'Invalid username/password combination'
      render 'new'
    end
  end

  def destroy
  end
end
