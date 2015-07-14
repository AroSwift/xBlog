describe 'User signup' do

		before :each do
			@user = FactoryGirl.build(:user) # Completely valid user
			visit new_user_path
		end
		
		it "successfully creates a new user given acceptable username and password" do
			fill_in "user_username", with: @user.username
			fill_in "user_password", with: @user.password
			fill_in "user_password_confirmation", with: @user.password
			click_button "Sign Up"

			expect(page).to have_text("Account")
		end


		it "fails to create a new user when username and password are blank" do
			fill_in "user_username", with: ""
			fill_in "user_password", with: ""
			fill_in "user_password_confirmation", with: ""
			click_button "Sign Up"

			expect(page).to have_text("can't be blank")
		end


		it "fails to create a new user when password and confirm password do not match" do
			fill_in "user_username", with: @user.username
			fill_in "user_password", with: @user.password
			fill_in "user_password_confirmation", with: @user.password + "nope"
			click_button "Sign Up"

			expect(page).to have_text("Password confirmation doesn't match Password")
		end

end


describe 'Edit User' do

		before :each do
			@user = FactoryGirl.create(:user) # Normal User
			FactoryGirl.create(:post)

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end
		
		it "successfully edits selected user" do
			click_on("Account")
			click_on("Edit Username or Password")

			expect(page).to have_field("user_username", with: @user.username)
			expect(page).to have_field("user_password", with: @user.password)
		end

end


describe 'User login' do

		before :each do
			@user = FactoryGirl.create(:user) # Completely valid user
			visit :login
		end
		
		it "successfully logs in a user with valid login credentials" do
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"

      # Then I expect to be logged in
			expect(page).to have_text("Create First Post")
			expect(page).to have_text("Account")
		end


		it "fails to login user when username and password are do not match" do
			fill_in "login_username", with: ""
			fill_in "login_password", with: ""
			click_button "Login"

			expect(page).to have_text("The username and password do not match")
		end

end


describe 'Delete User' do

		before :each do
			@user = FactoryGirl.create(:user, admin: true, superadmin: false) # Completely valid user

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end
		
		it "successfully deletes a user given acceptable user id" do
			click_on("Users")
			expect { click_link('Delete') }.to change(User, :count).by(-1)
			expect(page).to have_text("deleted")
		end

end