class AdminController < ApplicationController

	def create
	end

	def update
	end

	def logout
		@_current_user = session[:current_user_id] = nil
		@_current_user = session[:current_username] = nil   
		@_current_user = session[:admin] = nil   
		redirect_to :home
	end


	def destroy
		@dusername = params[:dusername]
		@dpassword = params[:dpassword]
		@dadmin = params[:dadmin]
		@type = params[:dtype]


		if @type == 'all' && @type != 'user' then

			User.where(:username => @dusername, :password => @dpassword).destroy_all
			Post.where(:author => @dusername).destroy_all

			redirect_to admin_home_path(:display => "The user #{@dusername} and all their posts were successfully deleted")
		else
			User.where(:username => @dusername, :password => @dpassword).destroy_all
			redirect_to admin_home_path(:display => "The user #{@dusername} was successfully deleted")
		end
	end

end
