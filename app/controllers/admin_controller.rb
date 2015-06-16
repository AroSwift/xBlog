class AdminController < ApplicationController


    # Admin Updates User
	def update
	  @username = params[:users][:username]
    @password = params[:users][:password]
    @confirm_password = params[:users][:confirm_password]
    @admin = params[:users][:admin]
    @id = params[:id]
    

    # Determines if admin wants edited user to be admin
    if @admin == 'true' || @admin == '1' then
    	@admin = true
    elsif @admin == 'false' || @admin == '0' then
    	@admin = false
    else
    	@admin = false
    end

    user = User.find_by_id(@id)
    user.username = @username
    user.password = @password
    user.admin = @admin
    user.valid?

    # Check for errors
    if user.errors.empty? then
    	if @confirm_password == @password then
          user.save(user_params)
          flash[:error] = "The user '#{@username}' was updated"
          redirect_to :admin_home
    	else
    		redirect_to admin_edit_users_path(:display => 'Your passwords do not match', :username => @username, :password => @password, :admin => @admin, :id => @id, :errors => user.errors.full_messages)
    	end

    else
      flash[:error] = user.errors.full_messages
      redirect_to admin_edit_users_path(:user => @username, :password => @password, :admin => @admin, :id => @id, :errors => user.errors.full_messages)
    end

	end


  # Logout Admin
	def logout
		@_current_user = session[:current_user_id] = nil
		@_current_user = session[:current_username] = nil 
    @_current_user = session[:current_password] = nil      
		@_current_user = session[:admin] = nil   
		redirect_to :home
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
			Post.where(:author => @dusername).destroy_all

			redirect_to admin_home_path(:display => "The user #{@dusername} and all their posts were successfully deleted")
		else
      # If Admin only wants to delete user
			User.where(:username => @dusername, :password => @dpassword).destroy_all
			redirect_to admin_home_path(:display => "The user #{@dusername} was successfully deleted")
		end
	end

	def user_params
    params.require(:users).permit(:username, :password, :admin, :id)
  end

end
