class Post < ActiveRecord::Base

	belongs_to :user, dependent: :destroy
	has_many :comments

	validates :title, :content, :author, :author_id, presence: true
	validates :title, uniqueness: true, on: :create
	validates :content, uniqueness: true, on: :create 
	validates :title, length: { in: 5..30 }
	validates :content, length: { in: 10..10000 } # CHANGE MIN CHARACTERS LATER

end




