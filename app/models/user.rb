class User < ActiveRecord::Base
	
	validates :username, :password, presence: true
	validates :username, length: { in: 5..12 }
	validates :password, length: { in: 8..20 }

end