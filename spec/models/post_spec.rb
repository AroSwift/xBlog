require 'factory_girl'


RSpec.describe Post, :type => :model do
	# Validates presences
	it { should validate_presence_of(:title) }	
	it { should validate_presence_of(:author) }	
	it { should validate_presence_of(:content) }	

	# Validates length
	it { should validate_length_of(:title).is_at_least(5) }
	it { should validate_length_of(:title).is_at_most(40) }

	it { should validate_length_of(:author).is_at_least(5) }
	it { should validate_length_of(:author).is_at_most(12) }

	it { should validate_length_of(:content).is_at_least(30) }
	it { should validate_length_of(:content).is_at_most(1500) }
end