class SessionsController < ApplicationController
  def new
    @user = User.new
    @password = Password.new(:password=>params[:password])
  end

  def create
    @username = params[:login][:username]
    @password = params[:login][:password]



if @username != @password then

      flash[:error] = "Your username and password do not match"
      redirect_to :back 
    else
      # DATABASE AND SESSION STUFF AFTER ALL CONDITIONS MEET

      redirect_to :home
    end
end


  def destroy
  end
end
