require 'spec_helper'

RSpec.describe UsersController, :type => :controller do


	describe 'Create User' do
		it "validates existance of username, password, and confirm password" do


		end


		it "confims password and confirm password are equal" do
		end


		it "checks if this is the first account" do
		end

	end




	describe 'Login' do

		before :each do
			@user = FactoryGirl.build(:user) # Completely valid user
		end
		

		it "validates presence of username and password" do

			# Valid User
			expect(@user.username).not_to be_empty
			expect(@user.password).not_to be_empty
			expect(@user.valid?).to be (true)

			# Invalid User
			@user.username = ''
			@user.password = ''
			expect(@user.username).to be_empty
			expect(@user.password).to be_empty
			expect(@user.valid?).to be (false)
		end


			it "validates length of username and password" do

			# Valid User
			#expect(@user.username.length).to be < 5 # Greater than or equal to 5
			#expect(@user.username.length).to be >= 8 # Less than or equal to 8
			#expect(@user.password.length).to be <= 8 # Greater than or equal to 8
			#expect(@user.username.length).to be >= 12 # Less than or equal to 12
			#expect(@user.valid?).to be (true)

			# Invalid User
			#@user.username = ''
			#expect(@user.username).to be_between(5, 20).exclusive
			#expect(@user.password).to be_between(5, 20).exclusive
			#expect(@user.valid?).to be (false)
		end


		it "creates a session" do
			session[:current_user_id] = @user.id
      session[:current_username] = @user.username
      session[:current_password] = @user.password

      expect(session[:current_user_id]).to eq(@user.id)
			expect(session[:current_username]).to eq(@user.username)
			expect(session[:current_password]).to eq(@user.password)
		end

	end





end
