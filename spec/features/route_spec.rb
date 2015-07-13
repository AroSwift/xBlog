describe 'Checking Public Routes' do

		# before :each do
		# end
		
		it "successfully accesses Root page" do
			visit :root
			expect(page).to have_text("Home")
		end


		it "successfully accesses Login page" do
			visit :login
			expect(page).to have_text("Login")
		end


		it "successfully accesses Signup page" do
			visit new_user_path
			expect(page).to have_text("Sign Up")
		end

end




describe 'Checking Logged In Routes' do

		before :each do
			@id = 1 # Completely valid link number
			@user = FactoryGirl.create(:user) # Completely valid user
			@post = FactoryGirl.create(:post)

			cookies[:current_username] = @user.username
			cookies[:current_password] = @user.password
			cookies[:current_user_id] = @user.id
			cookies[:admin] = @user.admin
			cookies[:super_admin] = @user.superadmin
		end



		it "successfully accesses New Post page", type: :request  do

			visit new_post_path
			expect(page).to have_text("Post")
		end


		it "successfully accesses Edit Post page", type: :request  do

			cookies[:current_username] = @user.username
			cookies[:current_password] = @user.password
			cookies[:current_user_id] = @user.id
			cookies[:admin] = @user.admin
			cookies[:super_admin] = @user.superadmin
			
			expect(cookies[:current_username]).to eq(@user.username)
			expect(cookies[:current_password]).to eq(@user.password)
			expect(cookies[:current_user_id]).to eq(@user.id)
			expect(cookies[:super_admin]).to eq(@user.superadmin)
			expect(cookies[:admin]).to eq(@user.admin)

			visit edit_post_path(@id)
			expect(page).to have_text("Edit Post")
		end

end



describe 'Checking Admin Routes' do
end

