class CommentsController < ApplicationController
include UsersHelper


  def new
     @comment = Comment.new
  end 

  def index
    @comments = Comment.all
  end


  # Create Comment
  def create
    com = Comment.new
    com.comment = params[:com][:comment]
    com.post_id = params[:com][:post_id]
    com.user_id = cookies.signed[:current_user_id]
    com.user = cookies.signed[:current_username]

    # Check for validation errors
    if com.valid? then
      com.save(comment_params)
    else
      flash[:errors] = com.errors.full_messages
    end

    redirect_to :root unless admin?
    redirect_to :admin_home unless !admin?
  end


  # Delete Comment
  def destroy
    Comment.destroy(params[:id])
    flash[:error] = 'The comment was successfully deleted'

    redirect_to :root unless admin?
    redirect_to :admin_home unless !admin?
  end


  # What is allowed in database
  private
  def comment_params
    params.require(:com).permit(:comment, :post_id, :user_id, :user)
  end

end