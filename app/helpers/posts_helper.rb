module PostsHelper

	# Checks if first post
	def first_post?
  	Post.count.zero?
  end
  
end
