module CommentsHelper

  def delete_comment_params_exist?
  	params[:user].present? && params[:comment].present? && params[:post_id].present?
  end

end