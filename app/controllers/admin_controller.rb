class AdminController < ApplicationController

	def create
	end

	def update
	end

	def destroy
	@_current_user = session[:current_user_id] = nil
    @_current_user = session[:current_username] = nil   
    @_current_user = session[:admin] = nil   
    redirect_to :home
	end
	
end
