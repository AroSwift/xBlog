class UsersController < ApplicationController
  def new
  	@username = Username.new
  	@password = Password.new
  end 

  def create

  end
end
