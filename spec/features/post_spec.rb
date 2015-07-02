require 'Factory_Girl'


describe 'New post' do	

		before :each do
			@post = FactoryGirl.build(:post) # Completely valid post
			# @user = FactoryGirl.build(:user) # Completely valid user
		end
		

		it "successfully creates new post given title and post content" do
			# Must be loged in before posting
			visit new_post_path

			# # Expect username to be in author field
			# expect()

			fill_in "post_title", with: @post.title
			fill_in "post_content", with: @post.content
			click_button "Post"

			# expect ? 
		end

end