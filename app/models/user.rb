class User < ActiveRecord::Base

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_one :requests, dependent: :destroy

	attr_accessor :password_confirmation # sets password_confirmation for one time use
	validates_confirmation_of :password # validates password == password_confirmation

	# Validates characteristics of user
	validates :username, uniqueness: true
	validates :password, confirmation: true
	validates :username, :password, presence: true
	validates :username, length: { in: 5..12 }
	validates :password, length: { in: 8..20 }

	# Fat model begins here:





end