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

	  @username = params[:users][:username]
    @password = params[:users][:password]
    @confirm_password = params[:users][:confirm_password]
    @admin = params[:users][:admin]


    # if @password != @confirm_password && !admin? && !super_admin? then
    #   redirect_to admin_edit_users_path(:id => params[:id])
    #   return
    # end


    # Determines if admin wants edited user to be admin
    if @admin == '1' || @admin == 'true' then
    	@admin = true
    else
    	@admin = false
    end

    # What username was before updating
    # Look into activesupport dirty class: User.username.changed?

    @id = params[:id]
    user = User.find(@id)
    @prename = user.username
  
    user.username = @username
    user.password = @password
    if !admin? || @prename != session[:current_username] then 
      user.admin = @admin
    end


    @user.save(user_params)
    @user.valid?

    if @user.changed? then
      flash[:error] = "The user '#{@username}' was updated."

      # Updates Posts and Comments user and author to match new username
      Post.where(:author => @prename).update_all(author: @username)
      Comment.where(:user => @prename).update_all(user: @username)
      Request.where(:accepted_by => @prename).update_all(accepted_by: @username)


    redirect_to account_user_path(session[:current_user_id]) unless admin?
    redirect_to :admin_users unless !admin?

    else
      flash[:errors] = @user.errors.full_messages


    end

	end


  # Admin Deletes User and/or their posts
	def destroy
    if delete_user_params_exist? then

  		@dusername = params[:dusername]
  		@dpassword = params[:dpassword]
  		@dadmin = params[:dadmin]

        # Delete user and all their posts and comments
  			User.where(:username => @dusername, :password => @dpassword).destroy_all
  			Post.where(:author => @dusername).destroy_all
        Comment.where(:user => @dusername).destroy_all

        # Sign out if current user
        if @dusername == session[:current_username] then
          @_current_user = session[:current_user_id] = nil
          @_current_user = session[:current_username] = nil 
          @_current_user = session[:current_password] = nil      
          @_current_user = session[:admin] = nil
          @_current_user = session[:super_admin] = nil 
        end 


        # If current user is deleting their account, posts and comments
        if @dusername == session[:current_username] then   
          redirect_to home_path(:display => "You have successfully deleted your account, posts, and comments")
        else
          redirect_to home_path(:display => "You have successfully deleted your account, posts, and comments") unless admin?
          redirect_to admin_users_path(:display => "The user #{@dusername} and all their posts and comments were successfully deleted") unless !admin?
        end

    # If the paramaters are not set
    else
      redirect_to home_path(:display => "Something went wrong. Please try again.") unless admin?
      redirect_to admin_home_path(:display => "Something went wrong. Please try again.") unless !admin?
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