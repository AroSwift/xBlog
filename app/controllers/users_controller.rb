class UsersController < ApplicationController
  def new
    @user = User.new
    @password = Password.new(:password=>params[:password])
  end

  def create
    @username = params[:users][:username]
    @password = params[:users][:password]
    @confirm_password = params[:users][:confirm_password]



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
     elsif @confirm_password.length != @password then

      flash[:error] = "Your passwords don't match"
      redirect_to :back 

    else
      # DATABASE STUFF AFTER ALL CONDITIONS MEET

      redirect_to :home
    end
end


  def destroy
  end
end
