require 'spec_helper'
require 'Factory_Girl'


	describe 'Login' do

		before :each do
			@user = FactoryGirl.build(:user) # Completely valid user
		end
		

		it "takes username and password" do
			visit :login
			fill_in "login_username", with: @user.username
			fill_in "login_password", with: @user.password
			click_button "Login"
		end


		it "validates presence of username and password" do

			# Valid User
			expect(@user.username).not_to be_empty
			expect(@user.password).not_to be_empty
			expect(@user.valid?).to be (true)

			# Invalid User
			@user.username = ''
			@user.password = ''
			expect(@user.username).to be_empty
			expect(@user.password).to be_empty
			expect(@user.valid?).to be (false)
		end


			it "validates length of username and password" do

			# Valid User
			#expect(@user.username.length).to be < 5 # Greater than or equal to 5
			#expect(@user.username.length).to be >= 8 # Less than or equal to 8
			#expect(@user.password.length).to be <= 8 # Greater than or equal to 8
			#expect(@user.username.length).to be >= 12 # Less than or equal to 12
			#expect(@user.valid?).to be (true)

			# Invalid User
			#@user.username = ''
			#expect(@user.username).to be_between(5, 20).exclusive
			#expect(@user.password).to be_between(5, 20).exclusive
			#expect(@user.valid?).to be (false)
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





	describe 'New post' do	

		before :each do
			@p = FactoryGirl.build(:post) # Completely valid post
		end


		it "takes title, current username, and post content" do
			visit :post
			fill_in "posts_title", with: @p.title
			# fill_in "posts_author", with: @p.author ## Should NOT have to fill the author field- should be pre-populated
			fill_in "posts_content", with: @p.post
			click_button "post"
		end


		it "validates presence of title, author, and post content" do

			# Valid new post
			expect(@p.title).not_to be_empty
			expect(@p.author).not_to be_empty
			expect(@p.content).not_to be_empty
			expect(@p.valid?).to be (true)

			# Invalid new post
			@p.title = ''
			expect(@p.title).to be_empty
			expect(@p.content).to be_empty
			expect(@p.valid?).to be (false)

			# Invalid new post
			@p.content = ''
			expect(@p.title).to be_empty
			expect(@p.content).to be_empty
			expect(@p.valid?).to be (false)
		end


		it "checks if title already exists in database" do
		end


	end

