class AdminController < ApplicationController
include UsersHelper


  def new
     @user = User.new
  end 

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end




  # What is allowed into the database
  private
	def user_params
    params.require(:users).permit(:username, :password, :admin, :id)
  end

  def post_params
    params.require(:users).permit(:author, :title, :content, :id, :author_id)
  end

end