class Post < ActiveRecord::Base

	belongs_to :user, dependent: :destroy

	validates :title, :content, :author, :author_id, presence: true
	validates :title, uniqueness: true, on: :create
	validates :content, uniqueness: true, on: :create 

end




