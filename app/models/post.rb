class Post < ActiveRecord::Base

	validates :title, presence: true, uniqueness: true, on: :create
	validates :title, presence: true, on: :update
	validates :author, presence: true
	validates :content, presence: true, uniqueness: true, on: :create 

	validates :title, length: { in: 5..40,    
	too_short: "must have at least %{count} characters",
    too_long: "must not have more than %{count} characters" }
	validates :content, length: { in: 20..10000, 	 # Change MIN value later
	too_short: "must have at least %{count} characters",
    too_long: "must not have more than %{count} characters" }

end




