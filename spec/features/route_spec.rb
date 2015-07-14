describe 'Not Logged In Route' do

		before :each do
			@id = 1
			FactoryGirl.create(:user)
		end
		
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


		it "fails to accesses any pages" do
			visit :no_page_exists
			expect(page).to have_text("Home")
		end

end




describe 'Regular Logged In Route' do

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

