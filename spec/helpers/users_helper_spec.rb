RSpec.describe UsersHelper, type: :helper do



describe "" do
		
		before :each do
			@user = FactoryGirl.create(:user) # Completely valid user
	    cookies.signed[:current_user_id] = @user.id
	    cookies.signed[:current_username] = @user.username
	    cookies.signed[:current_password] = @user.password

	    expect(cookies.signed[:current_user_id]).to eq(@user.id)
	    expect(cookies.signed[:current_username]).to eq(@user.username)
	    expect(cookies.signed[:current_password]).to eq(@user.password)
		end

		it "checks if super admin" do
			cookies[:super_admin] = @user.superadmin
			expect(cookies[:super_admin]).to eq(@user.superadmin)
		end


		it "checks if admin" do
			cookies.signed[:admin] = @user.admin
			expect(cookies.signed[:admin]).to eq(@user.admin)
		end

		it "checks if logged in" do
		end

		it "checks if passwords are equal" do
			password = @user.password
			expect(password).to eq(@user.password)
		end


end
end