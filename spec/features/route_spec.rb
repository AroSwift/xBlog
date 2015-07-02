describe 'Checking Routes' do

		before :each do
			@id = 1 # Completely valid link number

			@user = FactoryGirl.create(:user) # Completely valid user
		end
		
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


		it "successfully accesses New Post page" do
			visit new_user_path
			expect(page).to have_text("Post")
		end


		it "successfully accesses Edit Post page" do
			visit edit_post_path(@id)
			expect(page).to have_text("Edit Post")
		end


end