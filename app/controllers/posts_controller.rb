class PostsController < ApplicationController
include UsersHelper
include PostsHelper


  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  # def show
  #   @post = Post.new
  # end



  # Creates Post
  def create
    @post = Post.new(post_params)
    @post.title = params[:title]
    @post.author = params[:author]
    @post.content = params[:content]
    @post.author_id = session[:current_user_id]
    @post.valid?

    # Checks for errors
    if @post.valid? then
      @post.save(post_params)
      flash[:error] = 'Your post was created'

      redirect_to :home unless admin?
      redirect_to :admin_home unless !admin?
    else
      # Populates fields in view
      flash[:title] = params[:title]
      flash[:author] = params[:author]
      flash[:content] = params[:content]

      flash[:errors] = @post.errors.full_messages
      render "/posts/new" #(:errors => @post.errors.full_messages)
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


  # Deletes post
 def destroy
    if delete_post_params_exist? then
      @title = params[:title]
      @author = params[:author]
      @content = params[:content]

      Post.where(:title => @title, :author => @author, :content => @content).destroy_all

      redirect_to root_path(:display => "The post '#{@title}' was successfully deleted") unless admin?
      redirect_to admin_home_path(:display => "The post '#{@title}' was successfully deleted") unless !admin?
    
    # If the paramaters are not set
    else
      redirect_to root_path(:display => "Something went wrong. Please try again.") unless admin?
      redirect_to admin_home_path(:display => "Something went wrong. Please try again.") unless !admin?
    end
  end


  private
  # What fields can be saved to Database
  def post_params
    params.permit(:title, :author, :content, :id, :author_id)
  end

end
