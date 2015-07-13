class PostsController < ApplicationController
include UsersHelper


  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end


  # Creates Post
  def create
    post = Post.new
    post.title = params[:post][:title]
    post.author = cookies.signed[:current_username]
    post.content = params[:post][:content]
    post.user_id = cookies.signed[:current_user_id]

    # Checks for errors
    if post.valid? then
      post.save(post_params)
      flash[:error] = 'Your post was created'

      redirect_to :root unless admin?
      redirect_to :admin_home unless !admin?
    else # If validation errors
      flash[:title] = params[:post][:title]
      flash[:content] = params[:post][:content]

      flash[:errors] = post.errors.full_messages
      redirect_to :back
    end
  end


  # Updates Post
  def update
    post = Post.find(params[:id])
    post.title = params[:post][:title]
    post.content = params[:post][:content]

    # Checks if saved
    if post.valid? then
      post.save(post_params)
      flash[:error] = 'Your post was successfully updated'

      redirect_to :root unless admin?
      redirect_to :admin_home unless !admin?
    else # If validation errors
      flash[:title] = params[:post][:title]
      flash[:content] = params[:post][:content]
      
      flash[:errors] = post.errors.full_messages
      redirect_to :back
    end
  end


  # Deletes post and comments within
 def destroy
    Post.destroy(params[:id])
    flash[:error] = "The post was successfully deleted"
    
    redirect_to :root unless admin?
    redirect_to :admin_home unless !admin?
  end


  private
  # What fields can be saved to Database
  def post_params
    params.require(:post).permit(:title, :author, :content, :id, :user_id)
  end

end
