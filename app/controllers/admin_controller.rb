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
    if @admin == '1' then
    	@admin = true
    else
    	@admin = false
    end

    user = User.find_by_id(@id)
    user.username = @username
    @tempuser = user.username
    user.password = @password
    user.admin = @admin
    user.valid?

    # Check for errors
    if user.errors.empty? then
      # if passwords match OR if admin bypass
    	if @confirm_password == @password || admin? then
        user.save(user_params)

        p = Post.find_by_author_id(@id)
        if !p.nil? then
          p.author = @username
          p.save
        end

        # Update session to match new identity if it is current user
        if @username == @tempuser then
          session[:current_username] = @username
          session[:current_password] = @password
          session[:admin] = @admin
        end

        # Where to send user after updated
        if admin? then
          redirect_to admin_home_path(:display => "The user '#{@username}' was updated")
        else
          redirect_to home_path(:display => "Your username and password were successfully updated")
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
    redirect_to home_path(:display => 'Logout Sucessful')
	end


  # Admin Deletes User and/or their posts
	def destroy
		@dusername = params[:dusername]
		@dpassword = params[:dpassword]
		@dadmin = params[:dadmin]
		@type = params[:dtype]

    # If Admin wants to delete user AND ALL their posts
		if @type == 'all' && @type != 'user' then

			User.where(:username => @dusername, :password => @dpassword).destroy_all
      p = Post.find_by_username(@dusername)
			Post.where(:author => @dusername).destroy_all
      Comment.where(:post_id => p.id, :user => @dusername)


      # If current user is deleting their account, posts and comments
      if @dusername == session[:current_username] && admin? then
        @_current_user = session[:current_user_id] = nil
        @_current_user = session[:current_username] = nil 
        @_current_user = session[:current_password] = nil      
        @_current_user = session[:admin] = nil   
        redirect_to home_path(:display => "You have successfully deleted your account, posts, and comments")
      else
        redirect_to admin_home_path(:display => "The user #{@dusername} and all their posts and comments were successfully deleted")
		  end

    else # # If Admin only wants to delete user # #

			User.where(:username => @dusername, :password => @dpassword).destroy_all
			redirect_to admin_home_path(:display => "The user #{@dusername} was successfully deleted")

      # If current user is deleting their account, posts and comments
      if @dusername == session[:current_username] && admin? then
        @_current_user = session[:current_user_id] = nil
        @_current_user = session[:current_username] = nil 
        @_current_user = session[:current_password] = nil      
        @_current_user = session[:admin] = nil   
        redirect_to home_path(:display => "You have successfully deleted your account")
      else
        redirect_to admin_home_path(:display => "The user #{@dusername} was successfully deleted")
      end

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
