describe 'New Comment' do

		before :each do
			@comment = FactoryGirl.build(:comment)
			FactoryGirl.create(:post)
			visit :login
		end
		
		it "successfully creates a comment when non-admin" do
			@user = FactoryGirl.create(:user) # Normal User

			# Set Cookies
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"

			fill_in "com_comment", with: @comment.comment
			click_button "Comment"

			expect(page).to have_text(@user.username + ": " + @comment.comment)
		end


		it "successfully creates a comment when administrator" do
			@user = FactoryGirl.create(:user, admin: true) # Admin

			# Set Cookies
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"	

			fill_in "com_comment", with: @comment.comment
			click_button "Comment"

			expect(page).to have_text(@user.username + ": " + @comment.comment)
		end


		it "fails to create a comment when comment field is blank" do
			@user = FactoryGirl.create(:user) # Normal User

			# Set Cookies
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"		

			fill_in "com_comment", with: ""
			click_button "Comment"

			expect(page).to have_text("can't be blank")
		end

end



describe 'Delete Comment' do

		before :each do
			FactoryGirl.create(:post)
			FactoryGirl.create(:comment)
		end
		
		it "successfully deletes a comment when non-admin" do
			@user = FactoryGirl.create(:user) # Normal User

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"	

			find("#spec_com").click
			expect(page).to have_text("The comment was successfully deleted")
		end


		it "successfully deletes a comment when administrator" do
			@user = FactoryGirl.create(:user, admin: true) # Admin

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"		

			find("#spec_com").click
			expect(page).to have_text("The comment was successfully deleted")
		end

end