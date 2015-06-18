require 'spec_helper'

	describe 'User' do

		before :each do
			# Set up data structures needed for each test in describe block
			@user = User.new(username: "Username", password: "Password")
		end
		

		it "takes user username and password and authenticates successfully" do
			# # Will do the stuff in the before block

			# # Do things to the object
			# # ?

			# # Expect certain outcomes/states on the object
			# @usr.show.should == ""
			# expect(@usr).to eq()
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"

			@user.show.should == 'Succesful'
			expect(@user).to eq(@user)
		end


		it "validates presence of username" do
			# Will do the stuff in the before block
			pending

			# Set valid passwd

			# Don't set a username

			# Expect it to not be valid
            #expect( @usr.valid? ).to be(false)

		end


	end