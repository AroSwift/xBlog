class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @username = params[:users][:username]
    @password = params[:users][:password]



if @username.length < 8 then

      flash[:error] = 'Your username must be at least 8 characters'
      redirect_to :back
    elsif @password.length < 8 then

      flash[:error] = 'Your password must be at least 8 characters.'
      redirect_to :back
    else
      redirect_to :home
    end
  end


  def destroy
  end
end
