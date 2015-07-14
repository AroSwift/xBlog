describe 'User signup process' do

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
			expect(page).to have_text("Account")
		end


		it "fails to create a new user when username and password are blank" do
			visit new_user_path
			fill_in "user_username", with: ""
			fill_in "user_password", with: ""
			fill_in "user_password_confirmation", with: ""
			click_button "Sign Up"

			expect(page).to have_text("can't be blank")
		end

end


describe 'User login process' do

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
			expect(page).to have_text("Account")
		end


		it "fails to login user when username and password are do not match" do
			visit :login
			fill_in "login_username", with: ""
			fill_in "login_password", with: ""
			click_button "Login"

			expect(page).to have_text("The username and password do not match")
		end

end


describe 'Delete user process' do

		before :each do
			@user = FactoryGirl.create(:user, admin: true, superadmin: false) # Completely valid user

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end
		
		it "successfully deletes a user given acceptable user id" do
			visit :admin_users
			expect { click_link('Delete') }.to change(User, :count).by(-1)
			expect(page).to have_text("deleted")
		end

end