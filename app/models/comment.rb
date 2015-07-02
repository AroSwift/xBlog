class Comment < ActiveRecord::Base

	belongs_to :posts
	belongs_to :users

	validates :comment, :user, :post_id, :user_id, presence: true
	validates :comment, length: { in: 5..250 }
	validates :user, length: { in: 5..12 }

end
