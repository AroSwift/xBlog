class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @username = params[:users][:username]
    @password = params[:users][:password]
    if @username.empty? && @password.empty? then


      flash[:key] = 'Your input can not be blank.'
      redirect_to :back
    else

      redirect_to :home
    end
  end

  def destroy
  end
end
