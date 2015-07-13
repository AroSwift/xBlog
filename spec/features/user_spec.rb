require 'Factory_Girl'


describe 'the user signup process' do

		before :each do
			@user = FactoryGirl.build(:user) # Completely valid user
		end
		
		it "successfully creates a new user given acceptable username and password" do
			visit new_user_path
			fill_in "user_username", with: @user.username
			fill_in "user_password", with: @user.password
			fill_in "user_password_confirmation", with: @user.password
			click_button "Sign Up"

			expect(page).to have_text("Create First Post")
		end

end


describe 'the user login process' do

		before :each do
			@user = FactoryGirl.create(:user) # Completely valid user
		end
		
		it "successfully logs in a user with valid login credentials" do
			# And I fill out the login form and submit it
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"

      # Then I expect to be logged in
			expect(page).to have_text("Create First Post")
		end

end


describe 'deleting user process' do

		before :each do
			@user = FactoryGirl.create(:user) # Completely valid user
		end
		
		it "successfully deletes a user given acceptable user id" do
			# visit :signup
      # expect ?
		end

end