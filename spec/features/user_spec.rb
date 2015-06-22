require 'spec_helper'
require 'Factory_Girl'

	describe 'Login' do

		before :each do
			@user = FactoryGirl.create(:user) # Completely valid user
		end
		

		it "takes username and password" do
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"

		end


		it "validates presence of username and password" do

			# Valid User
			expect(@user.username).to eq(@user.username)
			expect(@user.password).to eq(@user.password)
			expect(@user.valid?).to be (true)

			# Invalid User
			@user.username = ''
			expect(@user.username).to eq(@user.username)
			expect(@user.password).to eq(@user.password)
			expect(@user.valid?).to be (false)
		end


	end





	describe 'SignUp' do

		before :each do
			@user = FactoryGirl.create(:user) # Completely valid user
		end
		
		it "takes username, password, confirm password" do
			visit :signup
			fill_in "signup_username", with: @user.username
			fill_in "signup_password", with: @user.password
			fill_in "signup_confirm_password", with: @user.password
			click_button "Sign Up"
		end


		it "validates presence of username and password" do
			
		end


		it "checks if user exists in database" do
		end


		it "gives the current user a session and redirects" do
		end





	end