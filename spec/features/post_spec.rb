describe 'New post' do	

		before :each do
			@post = FactoryGirl.build(:post)
			@user = FactoryGirl.create(:user)

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end
		

		it "successfully creates new post given title, author, and post content" do
			visit new_post_path

			expect(page).to have_field("post_author", with: @user.username)

			fill_in "post_title", with: @post.title
			fill_in "post_content", with: @post.content
			click_button "Post"

			expect(page).to have_text("Your post was created")
		end


		it "fails to create new post when title and content are blank" do
			visit new_post_path

			fill_in "post_title", with: ""
			fill_in "post_content", with: ""
			click_button "Post"

			expect(page).to have_text("can't be blank")
		end

end



describe 'Edit post' do	

		before :each do
			@post1 = FactoryGirl.create(:post) # Origonal post 
			@post2 = FactoryGirl.build(:post, title: "This is going to be UPDATED, Lighten", content: @post1.content + " More content to make everyone happy.") # New post
			@user = FactoryGirl.create(:user)

			# Set Cookies
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end
		

		it "successfully updates post given title, author, and post content" do
			visit edit_post_path(@post1.id)

			expect(page).to have_field("post_author", with: @user.username)

			fill_in "post_title", with: @post2.title
			fill_in "post_content", with: @post2.content
			click_button "Post"

			expect(page).to have_text("Your post was successfully updated")
		end


		it "fails to create update post when title and content are blank" do
			visit edit_post_path(@post1.id)

			fill_in "post_title", with: ""
			fill_in "post_content", with: ""
			click_button "Post"

			expect(page).to have_text("can't be blank")
		end

end