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
			@id = 1 # Completely valid link number
			@user = FactoryGirl.create(:user) # Completely valid user
			@post = FactoryGirl.create(:post)

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end



		it "successfully accesses New Post page", type: :request  do
			visit new_post_path
			expect(page).to have_text("Post")
		end


		it "successfully accesses Edit Post page", type: :request  do
			visit edit_post_path(@id)
			expect(page).to have_text("Edit Post")
		end

end



describe 'Checking Admin Routes' do
end

