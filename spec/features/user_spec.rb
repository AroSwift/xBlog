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

end