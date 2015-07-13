describe 'Checking Public Routes' do

		# before :each do
		# end
		
		it "successfully accesses Root page" do
			visit :root
			expect(page).to have_text("Home")
		end


		it "successfully accesses Login page" do
			visit :login
			expect(page).to have_text("Login")
		end


		it "successfully accesses Signup page" do
			visit new_user_path
			expect(page).to have_text("Sign Up")
		end

end




describe 'Checking Logged In Routes' do

		before :each do
			@user = FactoryGirl.create(:user) # Completely valid user
			@post = FactoryGirl.create(:post)

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end



		it "successfully accesses New Post page" do
			visit new_post_path
			expect(page).to have_text("Post")
		end


		it "successfully accesses Edit Post page" do
			visit edit_post_path(@post.id)
			expect(page).to have_text("Edit Post")
		end


		it "successfully accesses Account page" do
			visit account_user_path(@user.id)
			expect(page).to have_text("Account")
		end


		it "successfully accesses Edit User page" do
			visit edit_user_path(@user.id)
			expect(page).to have_text("Edit User")
		end

end



describe 'Checking Admin Routes' do


		before :each do
			@id = 1 # Completely valid link number
			@user = FactoryGirl.create(:user) # Completely valid user
			# @post = FactoryGirl.create(:post)

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end



		it "successfully accesses Users page" do
			visit :admin_users
			expect(page).to have_text("Users")
		end


		it "successfully accesses Admin Home page" do
			visit :admin_home
			expect(page).to have_text("Home")
		end


end

