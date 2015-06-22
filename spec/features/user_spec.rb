require 'spec_helper'
require 'Factory_Girl'


	describe 'Login' do

		before :each do
			@user = FactoryGirl.create(:user) # Completely valid user
		end
		

		it "takes username and password" do
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end


		it "validates presence of username and password" do

			# Valid User
			expect(@user.username).to eq(@user.username)
			expect(@user.password).to eq(@user.password)
			expect(@user.valid?).to be (true)

			# Invalid User
			@user.username = ''
			expect(@user.username).to eq(@user.username)
			expect(@user.password).to eq(@user.password)
			expect(@user.valid?).to be (false)
		end


			it "validates length of username and password" do

			# Valid User
			expect(@user.username).to be_between(5, 20).exclusive
			expect(@user.password).to be_between(5, 20).exclusive
			expect(@user.valid?).to be (true)

			# Invalid User
			@user.username = ''
			expect(@user.username).to be_between(5, 20).exclusive
			expect(@user.password).to be_between(5, 20).exclusive
			expect(@user.valid?).to be (false)
		end

	end





	describe 'SignUp' do

		before :each do
			@user = FactoryGirl.create(:user) # Completely valid user
		end
		
		it "takes username, password, and confirm password" do
			visit :signup
			fill_in "signup_username", with: @user.username
			fill_in "signup_password", with: @user.password
			fill_in "signup_confirm_password", with: @user.password
			click_button "Sign Up"
		end


		it "validates presence of username and password" do
			# Valid User
			expect(@user.username).to eq(@user.username)
			expect(@user.password).to eq(@user.password)
			expect(@user.valid?).to be (true)

			# Invalid User
			@user.username = ''
			expect(@user.username).to eq(@user.username)
			expect(@user.password).to eq(@user.password)
			expect(@user.valid?).to be (false)
		end


		it "checks if user already exists in database" do
		end


		it "gives the current user a session and redirects" do
		end

	end




	describe 'Logout' do	


		it "takes cookies and deletes them" do
		end


	end





	describe 'New Post' do	

		before :each do
			@post = FactoryGirl.create(:post) # Completely valid post
		end


		it "takes title, current username, and post content" do
			visit :post
			fill_in "posts_title", with: @post.title
			# fill_in "posts_author", with: @post.author ## Should NOT have to fill the author field- should be pre-populated
			fill_in "posts_content", with: @post.post
			click_button "Post"
		end


		it "validates presence of title, author, and post content" do

			# Valid new post
			expect(@post.title).not_to be_empty
			expect(@post.post).not_to be_empty
			expect(@post.valid?).to be (true)

			# Invalid new post
			@post.title = ''
			expect(@post.title).not_to be_empty
			expect(@post.post).not_to be_empty
			expect(@post.valid?).to be (false)

			# Invalid new post
			@post.post = ''
			expect(@post.title).not_to be_empty
			expect(@post.post).not_to be_empty
			expect(@post.valid?).to be (false)
		end


		it "checks if title already exists in database" do
		end


	end

