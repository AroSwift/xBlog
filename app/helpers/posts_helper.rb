module PostsHelper

  def first_post?
  	Post.count.zero?
  end

end
