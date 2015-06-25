require 'Factory_Girl'


describe 'the user login process' do

		before :each do
			@user = FactoryGirl.create(:user) # Completely valid user
		end
		
		it "successfully logs in a user with valid login credentials" do

			# Given a user exists (before block)

			# And I fill out the login form and submit it
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"

       # Then I expect to be logged in
       expect(   ).to eql(  )
		end

end



describe 'the user signup process' do

		before :each do
			@user = FactoryGirl.create(:user) # Completely valid user
		end
		
		it "successfully creates a new user given acceptable username and password" do
			visit :signup
			fill_in "signup_username", with: @user.username
			fill_in "signup_password", with: @user.password
			fill_in "signup_confirm_password", with: @user.password
			click_button "Sign Up"

      # expect ?
		end

end