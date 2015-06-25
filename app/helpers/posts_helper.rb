module PostsHelper

  def first_post?
  	Post.count.zero?
  end

  def update_post_params_exist?
  	params[:title].present? && params[:content].present? && params[:id].present?
  end

end
