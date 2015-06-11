class User < ActiveRecord::Base
	
	validates :username, presence: true, uniqueness: true, on: :create
	validates :password, presence: true
	validates :username, length: { in: 5..12 }
	validates :password, length: { in: 8..20 }
	validates :admin, :inclusion => { in: true, false }

	validates :username, length: { in: 5..12,    
	too_short: "must have at least %{count} characters",
    too_long: "must not have more than %{count} characters" }
	validates :password, length: { in: 8..20, 
	too_short: "must have at least %{count} characters",
    too_long: "must not have more than %{count} characters" }

end