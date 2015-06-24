RSpec.describe UsersController, :type => :controller do


	describe 'Create User' do

			before :each do
				@user = FactoryGirl.build(:user) # Completely valid user
			end

			it "validates presence of username and password" do
				# Valid User
				expect(@user.valid?).to be (true)

				# Invalid User
				@user.username = ''
				expect(@user.valid?).to be (false)
			end

			it "confims password and confirm password are equal" do
				expect(@user.password).to eq(@user.password)
			end

			it "checks if this is the first account" do
			end

			it "checks if user already exists in database" do
			end

			it "gives the current user a session and redirects" do
				session[:current_user_id] = @user.id
	      session[:current_username] = @user.username
	      session[:current_password] = @user.password

				#expect(response).to redirect_to :admin_home
			end

	end



	describe 'Login' do

			before :each do
				@user = FactoryGirl.build(:user) # Completely valid user
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

			it "creates a session" do
				session[:current_user_id] = @user.id
	      session[:current_username] = @user.username
	      session[:current_password] = @user.password

	      expect(session[:current_user_id]).to eq(@user.id)
				expect(session[:current_username]).to eq(@user.username)
				expect(session[:current_password]).to eq(@user.password)
			end

	end


	describe 'Logout' do	

			it "takes cookies and deletes them" do
			end

	end





end
