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

		User.where(:username => @dusername, :password => @dpassword, :admin => @dadmin).destroy_all
		redirect_to home_path(:display => "The post #{@dusername} was successfully deleted")
	end

end
