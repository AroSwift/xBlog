require 'factory_girl'


RSpec.describe Comment, :type => :model do
	# Validates presences
	it { should validate_presence_of(:comment) }	
	it { should validate_presence_of(:user) }	
	it { should validate_presence_of(:post_id) }	
	it { should validate_presence_of(:user_id) }	

	# Validates length
	it { should validate_length_of(:comment).is_at_least(5) }
	it { should validate_length_of(:comment).is_at_most(250) }

	it { should validate_length_of(:user).is_at_least(5) }
	it { should validate_length_of(:user).is_at_most(12) }
end