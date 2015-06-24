require 'rails_helper'
require 'factory_girl'


describe Post do
	# Validates presences
	it { should validate_presence_of(:title) }	
	it { should validate_presence_of(:author) }	
	it { should validate_presence_of(:content) }	

	# Validates length
	it { should validate_length_of(:title).is_at_least(5) }
	it { should validate_length_of(:title).is_at_most(40) }

	it { should validate_length_of(:author).is_at_least(5) }
	it { should validate_length_of(:author).is_at_most(12) }

	it { should validate_length_of(:content).is_at_least(10) }
	it { should validate_length_of(:content).is_at_most(10000) }
end