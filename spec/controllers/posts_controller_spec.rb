RSpec.describe PostsController, type: :controller do


	before :each do
		@post = FactoryGirl.build(:post) # Completely valid user
		cookies[:current_username] = @post.author
	end


	describe '#create' do

			it "submits a new post" do

			end

	end



	describe '#update' do

			it "sets a new title and content for selected post" do

			end

	end



	describe '#destroy' do

			it "deletes post and all comments connected" do
			end

	end





end
