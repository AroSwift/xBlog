class CommentsController < ApplicationController
include UsersHelper
include CommentsHelper


  def new
     @comment = Comment.new
  end 

  def index
    @comments = Comment.all
  end



  # Create Comment
  def create

    @com = Comment.new
    @com.comment = params[:com][:comment]
    @com.post_id = params[:post_id]
    @com.user = session[:current_username]

    # Check for validation errors
    if @com.valid? then
        com.save(comment_params)

      redirect_to :home unless admin?
      redirect_to :admin_home unless !admin?
      
    else
      render :root unless admin?
      render :admin_home unless !admin?

      #redirect_to home_path(:errors => com.errors.full_messages, :comment => @comment, :post_id => @post_id) unless admin?
      #redirect_to admin_home_path(:errors => com.errors.full_messages, :comment => @comment, :post_id => @post_id) unless !admin?
    end
  end


  # Delete Comment
  def destroy
    
      @user = params[:user]
      @comment = params[:comment]
      @post_id = params[:post_id]

      Comment.where(:user => @user, :comment => @comment, :post_id => @post_id).destroy_all
        
      redirect_to home_path(:display => "The comment was successfully deleted") unless admin?
      redirect_to admin_home_path(:display => "The comment was successfully deleted") unless !admin?

  end

  # What is allowed in database
  def comment_params
    params.require(:com).permit(:comment, :post_id, :user)
  end


end