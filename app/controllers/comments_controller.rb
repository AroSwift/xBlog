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
    @com.post_id = params[:com][:post_id]
    @com.user = session[:current_username]

    # Check for validation errors
    if @com.valid? then
      @com.save(comment_params)
    else
      flash[:errors] = @com.errors.full_messages
    end

    redirect_to :home unless admin?
    redirect_to :admin_home unless !admin?
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