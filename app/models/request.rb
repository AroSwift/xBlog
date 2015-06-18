class Request < ActiveRecord::Base

	validates :username, :password, :user_id, presence: true
	validates :username, length: { in: 5..12 }
	validates :password, length: { in: 8..20 }

end
