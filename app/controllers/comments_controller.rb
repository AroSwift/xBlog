class CommentsController < ApplicationController

include UsersHelper

  # Create Comment
  def create
    @comment = params[:com][:comment]
    @post_id = params[:post_id]

    com = Comment.new
    com.comment = @comment
    com.post_id = @post_id
    com.user = session[:current_username]
    com.valid?

    # Limit the number of comments per post ---5?

    # Check for validation errors
    if com.errors.empty? then
      com.save(comment_params)

      if admin?
        redirect_to :admin_home
      else
        redirect_to :home
      end
      
    else
      if admin?
        redirect_to admin_home_path(:errors => com.errors.full_messages, :comment => @comment, :post_id => @post_id)
      else
        redirect_to home_path(:errors => com.errors.full_messages, :comment => @comment, :post_id => @post_id)
      end
    end
  end


  # Delete Comment
  def destroy
    @user = params[:user]
    @comment = params[:comment]
    @post_id = params[:post_id]

    Comment.where(:user => @user, :comment => @comment, :post_id => @post_id).destroy_all

      
      if admin? then
        redirect_to admin_home_path(:display => "The comment was successfully deleted")
      else
        redirect_to home_path(:display => "The comment was successfully deleted")
      end
  end

  def comment_params
    params.require(:com).permit(:comment, :post_id, :user)
  end


end