class AdminController < ApplicationController
include UsersHelper


  # Admin Updates User
	def update
	  @username = params[:users][:username]
    @password = params[:users][:password]
    @confirm_password = params[:users][:confirm_password]
    @admin = params[:users][:admin]
    @id = params[:id]

    # Determines if admin wants edited user to be admin
    if @admin == '1' || @admin == 'true' then
    	@admin = true
    else
    	@admin = false
    end

    # What username was before updating
      pre = User.find_by_id(@id)
      @prename = pre.username


      user = User.find_by_id(@id)
      user.username = @username
      user.password = @password
      if !admin? || @prename != session[:current_username] then 
        user.admin = @admin
      end
      user.valid?

    # Check for errors
    if user.errors.empty? then
      # if passwords match OR if admin bypass
    	if @confirm_password == @password || admin? then
        user.save(user_params)

      
        # Updates Posts and Comments user and author to match new username
        Post.where(:author => @prename).update_all(author: @username)
        Comment.where(:user => @prename).update_all(user: @username)
        Request.where(:accepted_by => @prename).update_all(accepted_by: @username)


        # Update session to match new identity if it is current user
        if @prename == session[:current_username] then
          @prename = 'changed'
          session[:current_username] = @username
          session[:current_password] = @password
        end

        # Where to send user after updated
        if admin? && @prename != 'changed' then
          redirect_to admin_home_path(:display => "The user '#{@username}' was updated")
        else
          if admin? then
            redirect_to admin_home_path(:display => "Your username and password were successfully updated")
          else
            redirect_to home_path(:display => "Your username and password were successfully updated")
          end
        end

    	else
    		redirect_to admin_edit_users_path(:username => @username, :password => @password, :admin => @admin, :id => @id, :posts => @posts, :errors => user.errors.full_messages, :display => 'Your passwords do not match')
    	end

    else
      redirect_to admin_edit_users_path(:username => @username, :password => @password, :admin => @admin, :id => @id, :posts => @posts, :errors => user.errors.full_messages)
    end

	end


  # Logout Admin
	def logout 
  		@_current_user = session[:current_user_id] = nil
  		@_current_user = session[:current_username] = nil 
      @_current_user = session[:current_password] = nil      
  		@_current_user = session[:admin] = nil   
      @_current_user = session[:super_admin] = nil  
    redirect_to home_path(:display => 'Logout Sucessful')
	end


  # Admin Deletes User and/or their posts
	def destroy
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
      elsif admin? then
        redirect_to admin_users_path(:display => "The user #{@dusername} and all their posts and comments were successfully deleted")
		  else
        redirect_to home_path(:display => "You have successfully deleted your account, posts, and comments")
      end
	end


  # What is allowed into the database
	def user_params
    params.require(:users).permit(:username, :password, :admin, :id)
  end

  def post_params
    params.require(:users).permit(:author, :title, :content, :id, :author_id)
  end

end