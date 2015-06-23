class User < ActiveRecord::Base

	#foreign key somewhere here or in post.rb
	has_many :posts

	validates :username, uniqueness: true
	validates :username, :password, presence: true
	validates :username, length: { in: 5..12 }
	validates :password, length: { in: 8..20 }

end