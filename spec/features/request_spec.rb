describe 'Request to be Admin' do

		before :each do
			@user = FactoryGirl.create(:user) # Normal User
			FactoryGirl.create(:post)

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end
		
		it "successfully creates a request to be an admin" do
			visit account_user_path(@user.id)
			click_on("Request to be an admin")

			expect(page).to have_text("Your request has been submitted")
		end


		it "fails to create a request to be admin when request has already been made" do
			FactoryGirl.create(:request)
			visit account_user_path(@user.id)
			click_on("Request to be an admin")

			expect(page).to have_text("You have already submitted a request")
		end

end




describe 'Accepts Request to be Admin' do

		before :each do			
			FactoryGirl.create(:request_other_user)
			@user = FactoryGirl.create(:user, admin: true)

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end
		
		it "successfully accepts request to be admin when administrator" do
			# @admin = FactoryGirl.build(:user, admin: true, superadmin: false) # Admin
			visit :admin_users
			click_on("Yes")

			expect(page).to have_text("#{@admin.username} is now an administrator")
		end

end




describe 'Reject Request to be Admin' do

		# before :each do			
		# 	@admin = FactoryGirl.create(:user, admin: true, superadmin: false) # Admin
		# 	@super_admin = FactoryGirl.create(:user, admin: true, superadmin: true) # Super Admin
		# 	FactoryGirl.create(:request, )
		# end
		
		# it "successfully creates a request to be an admin" do
		# 	visit new_user_path
		# 	fill_in "user_username", with: @user.username
		# 	fill_in "user_password", with: @user.password
		# 	fill_in "user_password_confirmation", with: @user.password
		# 	click_button "Sign Up"

		# 	expect(page).to have_text("Create First Post")
		# 	expect(page).to have_text("Account")
		# end


		# it "fails to create a request to be admin" do
		# 	visit account_user(@user.id)
		# 	click_button "Request to be an admin"

		# 	expect(page).to have_text("You have already submitted a request")
		# end

end