describe 'Not Logged In Route' do

		before :each do
			@id = 1
			FactoryGirl.create(:user)
			visit :root
		end
		
		it "successfully accesses Root page" do
			click_link("Home")
			expect(page).to have_text("Home")
		end


		it "successfully accesses Login page" do
			click_link("Login")
			expect(page).to have_text("Login")
		end


		it "successfully accesses Signup page" do
			click_link("Sign Up")
			expect(page).to have_text("Sign Up")
		end



		# ::::::Pages non-logged in user should NOT be able to access:::::: #
		it "fails to accesses Admin Home page" do
			visit :admin_home
			expect(page).to have_text("You don't have access to this page")
		end


		it "fails to accesses Admin Users page" do
			visit admin_users_path
			expect(page).to have_text("You don't have access to this page")
		end


		it "fails to accesses Edit User page" do
			visit edit_user_path(@id)
			expect(page).to have_text("You don't have access to this page")
		end


		it "fails to accesses Account page" do
			visit account_user_path(@id)
			expect(page).to have_text("You don't have access to this page")
		end


		it "fails to accesses New Post page" do
			visit new_post_path
			expect(page).to have_text("You don't have access to this page")
		end


		it "fails to accesses Edit post page" do
			FactoryGirl.create(:post)
			visit edit_post_path(@id)
			expect(page).to have_text("You don't have access to this page")
		end


		# If no page exist; go to root
		it "redirects to root when page doesn't exist" do
			visit :no_page_exists
			expect(page).to have_text("Home")
		end

end




describe ' User Logged In Route' do

		before :each do
			@user = FactoryGirl.create(:user) # admin/super_admin set to false by default
			@post = FactoryGirl.create(:post)

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end



		it "successfully accesses New Post page" do
			click_link("Post")
			expect(page).to have_text("Post")
		end


		it "successfully accesses Edit Post page" do
			click_link("Edit")
			expect(page).to have_text("Edit Post")
		end


		it "successfully accesses Account page" do
			click_link("Account")
			expect(page).to have_text("Account")
		end


		it "successfully accesses Edit User page" do
			click_link("Account")
			click_link("Edit Username or Password")
			expect(page).to have_text("Edit User")
		end




		# ::::::Pages regular user should NOT be able to access:::::: #
		it "fails to accesses Admin Home page" do
			visit :admin_home
			expect(page).to have_text("You don't have access to this page")
		end


		it "fails to accesses Admin Users page" do
			visit admin_users_path
			expect(page).to have_text("You don't have access to this page")
		end


		it "fails to accesses Signup page" do
			visit new_user_path
			expect(page).to have_text("You don't have access to this page")
		end


		it "fails to accesses Login page" do
			visit :login
			expect(page).to have_text("You don't have access to this page")
		end

end



describe 'Admin Routes' do

		before :each do
			@user = FactoryGirl.create(:user, admin: true, superadmin: false)
			@post = FactoryGirl.create(:post)

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end



		it "successfully accesses Admin Home page" do
			click_link("Home")
			expect(page).to have_text("Home")
		end


		it "successfully accesses Users page" do
			click_link("Users")
			expect(page).to have_text("Users")
		end


		it "successfully accesses Account page" do
			click_link("Account")
			expect(page).to have_text("Account")
		end


		it "successfully accesses New Post page" do
			click_link("Post")
			expect(page).to have_text("Post")
		end


		it "successfully accesses Edit Post page" do
			click_link("Edit")
			expect(page).to have_text("Edit Post")
		end


		it "successfully accesses Edit User page" do
			click_link("Account")
			click_link("Edit Username or Password")
			expect(page).to have_text("Edit User")
		end




		# ::::::Pages admin user should NOT be able to access:::::: #
		it "fails to accesses Signup page" do
			visit new_user_path
			expect(page).to have_text("You don't have access to this page")
		end


		it "fails to accesses Login page" do
			visit :login
			expect(page).to have_text("You don't have access to this page")
		end

end




describe 'Super Admin Routes' do


		before :each do
			@user = FactoryGirl.create(:user, admin: true, superadmin: true) # Completely valid user
			@post = FactoryGirl.create(:post)

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end



		it "successfully accesses Admin Home page" do
			click_link("Home")
			expect(page).to have_text("Home")
		end


		it "successfully accesses Users page" do
			click_link("Users")
			expect(page).to have_text("Users")
		end


		it "successfully accesses Account page" do
			click_link("Account")
			expect(page).to have_text("Account")
		end


		it "successfully accesses New Post page" do
			click_link("Post")
			expect(page).to have_text("Post")
		end


		it "successfully accesses Edit Post page" do
			click_link("Edit")
			expect(page).to have_text("Edit Post")
		end


		it "successfully accesses Edit User page" do
			click_link("Account")
			click_link("Edit Username or Password")
			expect(page).to have_text("Edit User")
		end



		# ::::::Pages super admin user should NOT be able to access:::::: #
		it "fails to accesses Signup page" do
			visit new_user_path
			expect(page).to have_text("You don't have access to this page")
		end


		it "fails to accesses Login page" do
			visit :login
			expect(page).to have_text("You don't have access to this page")
		end


end

