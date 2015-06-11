class Post < ActiveRecord::Base

	validates :title, presence: true, uniqueness: true
	validates :author, presence: true 
	validates :content, presence: true 

	validates :title, length: { in: 5..40,    
	too_short: "must have at least %{count} characters",
    too_long: "must not have more than %{count} characters" }
	validates :content, length: { in: 20..10000, 	 # Change MIN value later
	too_short: "must have at least %{count} characters",
    too_long: "must not have more than %{count} characters" }

end




