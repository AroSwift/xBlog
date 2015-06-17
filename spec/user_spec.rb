require 'spec_helper'

	describe 'User model' do

		before(:each) do
			# Set up data structures needed for each test in describe block
			@usr = User.new( )

		end
		
		it "takes user username and password and authenticates successfully" do
			# # Will do the stuff in the before block

			# # Do things to the object
			# # ?

			# # Expect certain outcomes/states on the object
			# @usr.show.should == ""
			# expect(@usr).to eq()
		end

		it "validates presence of username" do
			# Will do the stuff in the before block
			pending

			# Set valid passwd

			# Don't set a username

			# Expect it to not be valid
            expect( @usr.valid? ).to be(false)

		end


	end