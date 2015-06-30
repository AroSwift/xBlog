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


  # Admin Updates User
	def update
    @user = User.find(params[:id])
    prename = @user.username

	  username = params[:users][:username]
    password = params[:users][:password]
    confirm_password = params[:users][:confirm_password]
    admin = params[:users][:admin]

    # Determines if admin wants edited user to be admin
    if admin == '1' || admin == 'true' then
    	admin = true
    else
    	admin = false
    end


    # If not admin and not current user, update selected user to admin
    if !admin? || prename != session[:current_username] then 
      user.admin = admin
    end

    # If user successfully updated
    if user.valid? then  
      user.save(user_params)
      flash[:error] = "The user '#{username}' was updated."

      # Updates Posts and Comments user and author to match new username
      Post.where(:author => prename).update_all(author: username)
      Comment.where(:user => prename).update_all(user: username)
      Request.where(:accepted_by => prename).update_all(accepted_by: username)

      redirect_to account_user_path(session[:current_user_id]) unless admin?
      redirect_to :admin_users unless !admin?
    else
      flash[:errors] = user.errors.full_messages
      redirect_to :back
    end
	end


  # Admin Deletes User and/or their posts
	def destroy
    @user = User.find(params[:id])
		@dusername = params[:dusername]

    # Delete user and all their posts and comments
		User.where(:username => @dusername).destroy_all
		Post.where(:author => @dusername).destroy_all
    Comment.where(:user => @dusername).destroy_all

    # Sign out if current user
    if @dusername == session[:current_username] then
      # @_current_user = session[:current_user_id] = nil
      # @_current_user = session[:current_username] = nil 
      # @_current_user = session[:current_password] = nil      
      # @_current_user = session[:admin] = nil
      # @_current_user = session[:super_admin] = nil 
      reset_session
    end 


    # If current user is deleting their account, posts and comments
    if @dusername == session[:current_username] then   
      flash[:error] = 'You have successfully deleted your account, posts, and comments'
      redirect_to :root
    else
      flash[:error] = 'The user #{@dusername} and all their posts and comments were successfully deleted'
      redirect_to :root unless admin?
      redirect_to :admin_users unless !admin?
    end
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