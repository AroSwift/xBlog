class Comment < ActiveRecord::Base

	belongs_to :posts
	belongs_to :users

	validates :comment, :post_id, :user, presence: true
	validates :comment, length: { in: 5..250 }
	validates :user, length: { in: 5..12 }

end
