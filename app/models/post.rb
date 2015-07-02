class Post < ActiveRecord::Base

	has_one :users
	has_many :comments, dependent: :destroy

	validates :title, :content, :author, :user_id, presence: true
	validates :title, uniqueness: true #, on: :create
	validates :content, uniqueness: true #, on: :create 
	validates :title, length: { in: 5..40 }
	validates :author, length: { in: 5..12 }
	validates :content, length: { in: 30..1500 } # CHANGE MIN CHARACTERS LATER

end




