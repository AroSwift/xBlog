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

    # Check for validation errors
    if com.errors.empty? then
        com.save(comment_params)

      redirect_to :home unless admin?
      redirect_to :admin_home unless !admin?
      
    else
      redirect_to home_path(:errors => com.errors.full_messages, :comment => @comment, :post_id => @post_id) unless admin?
      redirect_to admin_home_path(:errors => com.errors.full_messages, :comment => @comment, :post_id => @post_id) unless !admin?
    end
  end


  # Delete Comment
  def destroy
    if delete_comment_params_exist?
      @user = params[:user]
      @comment = params[:comment]
      @post_id = params[:post_id]

      Comment.where(:user => @user, :comment => @comment, :post_id => @post_id).destroy_all
        
      redirect_to home_path(:display => "The comment was successfully deleted") unless admin?
      redirect_to admin_home_path(:display => "The comment was successfully deleted") unless !admin?

    # What is allowed in database
    def comment_params
      params.require(:com).permit(:comment, :post_id, :user)
    end

    # If the paramaters are not set
    else
      redirect_to :home unless admin?
      redirect_to :admin_home unless !admin?
    end

end