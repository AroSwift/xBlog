class Post < ActiveRecord::Base

	belongs_to :user, dependent: :destroy

	validates :title, :content, :author, presence: true
	validates :title, uniqueness: true, on: :create
	validates :content, uniqueness: true, on: :create 

	validates :title, length: { in: 5..40,    
	too_short: "must have at least %{count} characters",
    too_long: "must not have more than %{count} characters" }
	validates :content, length: { in: 20..10000, 	 # Change MIN value later
	too_short: "must have at least %{count} characters",
    too_long: "must not have more than %{count} characters" }

end




