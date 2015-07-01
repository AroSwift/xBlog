require 'Factory_Girl'


describe 'New post' do	

		before :each do
			@p = FactoryGirl.build(:post) # Completely valid post
			@user = FactoryGirl.build(:user) # Completely valid user
		end

		it "takes username and password to login user" do
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"

			# expect ?
		end


		it "successfully creates new post given title and post content" do
			# Must be loged in before posting
			visit :post
			fill_in "posts_title", with: @p.title
			fill_in "posts_content", with: @p.post
			click_button "Post"

			# expect ? 
		end

end