class PostsController < ApplicationController
include UsersHelper
include PostsHelper


  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end


  # Creates Post
  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.author = session[:current_username]
    @post.content = params[:post][:content]
    @post.author_id = session[:current_user_id]

    # Checks for errors
    if @post.valid? then
      @post.save(post_params)
      flash[:error] = 'Your post was created'

      redirect_to :home unless admin?
      redirect_to :admin_home unless !admin?
    else
      # Populates fields in view
      flash[:title] = params[:post][:title]
      flash[:content] = params[:post][:content]

      flash[:errors] = @post.errors.full_messages
      redirect_to :back
    end
  end


  # Updates Post
  def update
    @post = Post.find_by_id(params[:id])
    @post.title = params[:title]
    @post.content = params[:content]
    @post.author = session[:current_username]
    @post.author_id = session[:current_user_id]
    @post.valid?
    @post.save(post_params)


    # Checks if saved
    if @post.save? then
      flash[:error] = 'Your post was successfully updated'
      redirect_to :home unless admin?
      redirect_to :admin_home unless !admin?
    else
      flash[:errors] = @post.errors.full_messages
      render edit_post_path(params[:id])
    end
  end


  # Deletes post and comments within
 def destroy
    Post.where(:id => params[:id]).destroy_all
    Comment.where(:post_id => params[:id]).destroy_all

    flash[:error] = "The post '#{params[:title]}' was successfully deleted"
    redirect_to :home unless admin?
    redirect_to :admin_home unless !admin?
  end


  private
  # What fields can be saved to Database
  def post_params
    params.permit(:title, :author, :content, :id, :author_id)
  end

end
