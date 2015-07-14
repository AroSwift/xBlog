describe 'New post' do	

		before :each do
			@post = FactoryGirl.build(:post) # Completely valid post
			@user = FactoryGirl.create(:user) # Completely valid user

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end
		

		it "successfully creates new post given title, author, and post content" do
			# Must be loged in before posting
			visit new_post_path

			# expect(page).to have_field("post_author", text: @user.username)
			expect(page).to have_field("post_author", with: @user.username)

			fill_in "post_title", with: @post.title
			fill_in "post_content", with: @post.content
			click_button "Post"

			# expect ? 
			# expect(find_field("post_author").text).to eq(@user.username)
		end


end