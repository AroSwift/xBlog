require 'factory_girl'


RSpec.describe User, :type => :model do
	# Validates presences
	it { should validate_presence_of(:username) }	
	it { should validate_presence_of(:password) }	

	# Validates length
	it { should validate_length_of(:username).is_at_least(5) }
	it { should validate_length_of(:username).is_at_most(12) }
	it { should validate_length_of(:password).is_at_least(8) }
	it { should validate_length_of(:password).is_at_most(20) }
end
