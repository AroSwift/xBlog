describe 'Checking Public Routes' do

		before :each do
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

end




describe 'Checking Logged In Routes' do

		before :each do
			@id = 1 # Completely valid link number
			@user = FactoryGirl.create(:user) # Completely valid user
			@post = FactoryGirl.create(:post)

			# Create cookies to simulated logged in state
			# cookies[:current_username] = @user.username
			# cookies[:current_password] = @user.password
			# cookies[:current_user_id] = @user.id
			# cookies[:admin] = @user.admin
			# cookies[:super_admin] = @user.superadmin
			# request.cookies[:current_user_id] = @user.id
			# request.cookies[:admin] = @user.admin
			# request.cookies[:super_admin] = @user.superadmin

			page.driver.browser.set_cookie 'username=jhendrix'
		end

		it "successfully accesses New Post page", type: :request  do

			visit new_post_path
			expect(page).to have_text("Post")
		end


		it "successfully accesses Edit Post page", type: :request  do
			@request.cookies['current_username'] = @user.username
			cookies[:current_password] = @user.password
			cookies[:current_user_id] = @user.id
			cookies[:admin] = @user.admin
			cookies[:super_admin] = @user.superadmin

			visit edit_post_path(@id)
			expect(page).to have_text("Edit Post")
		end

end



describe 'Checking Admin Routes' do
end

