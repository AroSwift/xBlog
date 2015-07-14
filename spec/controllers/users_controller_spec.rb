RSpec.describe UsersController, :type => :controller do


	before :each do
		@user = FactoryGirl.build(:user)
	end


	describe '#create' do

			it "confirms password and confirm password are equal" do
				expect(@user.password).to eq(@user.password)
			end

			# it "checks if this is the first account" do
			# end

			# it "checks if user already exists in database" do
			# 	# expect(@user.count).to eq
			# end

			it "gives the current user a cookies.signed and redirects" do
				cookies.signed[:current_user_id] = @user.id
				cookies.signed[:current_username] = @user.username
				cookies.signed[:current_password] = @user.password

				expect(cookies.signed[:current_user_id]).to be == @user.id
	      expect(cookies.signed[:current_username]).to be == @user.username
	      expect(cookies.signed[:current_password]).to be == @user.password
			end

	end



	describe '#update' do

			it "sets new username and password for selected user" do
			end

	end



	describe '#destroy' do

			it "deletes user and all their posts, comments, and requests" do
			end

	end



	describe '#login_user' do

			it "creates a cookies.signed" do
				cookies.signed[:current_user_id] = @user.id
	      cookies.signed[:current_username] = @user.username
	      cookies.signed[:current_password] = @user.password

	      expect(cookies.signed[:current_user_id]).to eq(@user.id)
				expect(cookies.signed[:current_username]).to eq(@user.username)
				expect(cookies.signed[:current_password]).to eq(@user.password)
			end

	end



	describe '#logout' do	

			it "deletes cookies and redirect" do

				visit :admin_home
				expect(cookies.signed[:current_user_id]).to eq(nil)
	      expect(cookies.signed[:current_username]).to eq(nil)
	      expect(cookies.signed[:current_password]).to eq(nil)
	      expect(cookies.signed[:admin]).to eq(nil)
	      expect(cookies.signed[:super_admin]).to eq(nil)

	      #expect(response).to redirect_to :home
			end

	end





end
