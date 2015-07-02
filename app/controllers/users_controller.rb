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

    # Checks if password is not equal
    if !equal_password? then
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
    else # If errors
      flash[:errors] = user.errors.full_messages
      redirect_to :back
    end
  end


  # Updates User
  def update
    user = User.find(params[:id])
    prename = user.username
    user.username = params[:user][:username]
    user.password = params[:user][:password]

    # Populate fields
    flash[:username] = params[:user][:username]
    flash[:password] = params[:user][:password]
    flash[:admin] = params[:user][:admin]

    # Checks if password is not equal
    if !equal_password? && !admin? then
      flash[:error] = 'Your passwords do not match'
      redirect_to :back
      return
    end


    # If admin AND not current user, update selected user to admin
    if admin? && prename != session[:current_username] then 
      user.admin = true unless params[:user][:admin] == '0'
      user.admin = false unless params[:user][:admin] == '1'
    end

    # If user successfully updated
    if user.valid? then  
      user.save(user_params)
      flash[:error] = "The user was successfully updated."

      # Updates Posts and Comments user and author to match new username
      Post.where(:author => prename).update_all(author: params[:user][:username])
      Comment.where(:user => prename).update_all(user: params[:user][:username])
      
      # Creates new request to be checked by super admin
      if params[:user][:admin] == '1' && admin? && !super_admin? then
        r = Request.new
        r.status = true
        r.accepted_by = session[:current_username]
        r.username = params[:user][:username]
        r.password = params[:user][:password]
        r.user_id = params[:id]
        if r.valid? then
          r.save(request_params)
        else
          flash[:errors] = r.errors.full_messages
        end
      end

      redirect_to account_user_path(session[:current_user_id]) unless admin?
      redirect_to :admin_users unless !admin?
    else
      flash[:errors] = user.errors.full_messages
      redirect_to :back
    end
  end


  # Admin Deletes User and/or their posts
  def destroy
    User.destroy(params[:id])


    # If current user is deleting their account, posts and comments
    if params[:id] == session[:current_user_id] then   
      flash[:error] = 'You have successfully deleted your account, posts, and comments'
      reset_session
      redirect_to :root
    else
      flash[:error] = 'The user #{user.username} and all their posts and comments were successfully deleted'
      redirect_to :root unless admin?
      redirect_to :admin_users unless !admin?
    end
  end


  # Login User
  def login_user
    # Check if user exists in db
    user = User.find_by(username: params[:login][:username], password: params[:login][:password])
    
    # Checks if user exists in db
    if !user.nil? then
      session[:current_user_id] = user.id
      session[:current_username] = user.username
      session[:current_password] = user.password

      # If user is admin
      if user.admin == true then
        session[:admin] = true
      end

      # if user is super admin
      if user.superadmin == true then
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
    params.require(:user).permit(:author, :title, :content, :id, :user_id)
  end

  def request_params
    params.permit(:username, :password, :user_id, :status, :accepted_by)
  end

end
