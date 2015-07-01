class UsersController < ApplicationController
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


  # Create User
  def create
    user = User.new
    user.username = params[:user][:username]
    user.password = params[:user][:password]
    
    flash[:username] = params[:user][:username]
    flash[:password] = params[:user][:password]

    if params[:user][:password] != params[:user][:password_confirmation] then
      flash[:error] = 'Your passwords do not match'
      redirect_to :back
      return
    end

    # Checks for errors
    if user.valid? then
      # User first user?
      if first_user? then
        user.admin = true
        user.superadmin = true

        # Create session for super admin
        session[:admin] = true
        session[:super_admin] = true
      end

      # Save user to db
      user.save(user_params)

      # Create Session
      session[:current_user_id] = user.id
      session[:current_username] = user.username
      session[:current_password] = user.password

      redirect_to :root unless admin?
      redirect_to :admin_home unless !admin?

    # If errors
    else
      flash[:errors] = user.errors.full_messages
      redirect_to :back
    end
  end



  # Admin Updates User
  def update
    @password_confirmation = params[:user][:password_confirmation]
    user = User.find(params[:id])
    prename = user.username

    # Determines if admin wants edited user to be admin
    if params[:user][:admin] == '1' || params[:user][:admin] == 'true' then
      params[:user][:admin] = true
    else
      params[:user][:admin] = false
    end

    user.username = params[:user][:username]
    user.password = params[:user][:password]


    # If not admin and not current user, update selected user to admin
    if !admin? || prename != session[:current_username] then 
      user.admin = params[:user][:admin]
    end

    # If user successfully updated
    if user.valid? then  
      user.save(user_params)
      flash[:error] = "The user was successfully updated."

      # Updates Posts and Comments user and author to match new username
      Post.where(:author => prename).update_all(author: params[:user][:username])
      Comment.where(:user => prename).update_all(user: params[:user][:username])
      Request.where(:accepted_by => prename).update_all(accepted_by: params[:user][:username])

      redirect_to account_user_path(session[:current_user_id]) unless admin?
      redirect_to :admin_users unless !admin?
    else
      flash[:username] = params[:user][:username]
      flash[:password] = params[:user][:password]
      flash[:admin] = params[:user][:admin]

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


  # Login User
  def login_user
    # Check if user exists in db
    dbuser = User.find_by(username: params[:login][:username], password: params[:login][:password])
    
    # Checks if user exists in db
    if !dbuser.nil? then
      session[:current_user_id] = dbuser.id
      session[:current_username] = dbuser.username
      session[:current_password] = dbuser.password


      status = User.find_by_username(params[:login][:username])
      # If user is admin
      if status.admin == true then
        session[:admin] = true
      end

      # if user is super admin
      if status.superadmin == true then
        session[:super_admin] = true
      end

      redirect_to :root unless admin?
      redirect_to :admin_home unless !admin?
    else
      flash[:username] = params[:login][:username]
      flash[:password] = params[:login][:password]

      flash[:error] = 'The username and password do not match'
      redirect_to :back
    end
  end


  # Logout User
  def logout 
    # @_current_user = session[:current_user_id] = nil
    # @_current_user = session[:current_username] = nil 
    # @_current_user = session[:current_password] = nil      
    # @_current_user = session[:admin] = nil   
    # @_current_user = session[:super_admin] = nil  

    reset_session

    flash[:error] = 'Logout successful'
    redirect_to :root
  end


  private
  # What fields can be saved to Database
  def user_params
    params.require(:user).permit(:username, :password, :admin, :superadmin, :id)
  end

  def post_params
    params.require(:user).permit(:author, :title, :content, :id, :author_id)
  end

end
