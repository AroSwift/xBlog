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



describe 'Admin Reviews Request' do


		before :each do			
			FactoryGirl.create(:request, username: "MannyDanny")
			@user = FactoryGirl.create(:user, admin: true)

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end

		it "successfully accepts request to be admin when administrator" do
			visit :admin_users
			click_on("Yes")

			expect(page).to have_text("#{@user.username} is now an administrator")
		end
		
		it "successfully rejects request to be admin when administrator" do
			visit :admin_users
			click_on("No")

			expect(page).to have_text("#{@user.username} has been rejected administratorship")
		end

end




describe 'Super Admin Reviews Request' do


		before :each do			
			@user = FactoryGirl.create(:user, admin: true, superadmin: true) # super admin
			@requester = FactoryGirl.create(:user, username: "MannyDanny", id: 3) # user wanting adminship
			@admin = FactoryGirl.create(:user, username: "AdminDude", admin: true, id: 2) # another admin

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end

		it "successfully accepts request to be admin when administrator" do
			FactoryGirl.create(:request, username: @requester.username, accepted_by: @admin.username, user_id: 3)
			visit :admin_users
			click_on("Yes")

			expect(page).to have_text("#{@requester.username} is now an administrator")
		end
		
		it "successfully rejects request to be admin when administrator" do
			FactoryGirl.create(:request, username: @requester.username, rejected_by: @admin.username, user_id: 3)
			visit :admin_users
			click_on("No")

			expect(page).to have_text("#{@requester.username} has been rejected administratorship")
		end

end