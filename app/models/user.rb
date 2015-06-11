class User < ActiveRecord::Base

	has_many :posts

	validates :username, :password, presence: true
	validates :username, length: { in: 5..12 }
	validates :password, length: { in: 8..20 }

	validates :username, length: { in: 5..12,    
	too_short: "must have at least %{count} characters",
    too_long: "must not have more than %{count} characters" }
	validates :password, length: { in: 8..20, 
	too_short: "must have at least %{count} characters",
    too_long: "must not have more than %{count} characters" }

end