class User < ActiveRecord::Base

	has_many :posts

	validates :username, uniqueness: true, on: :show
	validates :username, :password, presence: true
	validates :username, length: { in: 5..12 }
	validates :password, length: { in: 8..20 }

	attr_accessor :password_confirmation
	validates_confirmation_of :password


	# Fat model begins here:





end