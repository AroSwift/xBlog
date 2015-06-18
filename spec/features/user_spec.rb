require 'spec_helper'
require 'Factory_Girl'

	describe 'Login' do

		before :each do
			@user = FactoryGirl.create(:user) # Completely valid user
		end
		

		it "takes username and password and authenticates successfully" do
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
			#@user = FactoryGirl.create(:user) # Completely valid user
		end
		
		it "validates presence of username and password" do
			
		end


	end