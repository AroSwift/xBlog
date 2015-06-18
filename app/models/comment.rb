class Comment < ActiveRecord::Base

	belongs_to :posts

	validates :comment, :post_id, :user, presence: true
	validates :comment, length: { in: 5..1000 }
	validates :user, length: { in: 8..12 }

end
