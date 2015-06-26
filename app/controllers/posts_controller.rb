class PostsController < ApplicationController
include UsersHelper
include PostsHelper


  def new
    @post = Post.new
  end


  # Updates Post
  def edit
    if update_post_params_exist? then

      @title = params[:title]
      @content = params[:content]
      @id = params[:id]

      post = Post.find_by_id(@id)
      post.title = @title
      post.content = @content
      post.author = session[:current_username]
      post.author_id = session[:current_user_id]
      post.valid?

      # Checks for errors
      if post.errors.empty? then
        post.save(post_params)

        redirect_to home_path(:display => 'Your post was successfully updated') unless admin?
        redirect_to admin_home_path(:display => 'Your post was successfully updated') unless !admin?

      else
        redirect_to edit_post_path(:title => @title, :author => session[:current_username], :content => @content, :id => @id, :errors => post.errors.full_messages)
      end

    # If the paramaters are not set
    else
      redirect_to home_path(:display => "Something went wrong. Please try again.") unless admin?
      redirect_to admin_home_path(:display => "Something went wrong. Please try again.") unless !admin?
    end
  end


  # Creates Post
  def create
    @title = params[:posts][:title]
    @author = params[:posts][:author]
    @content = params[:posts][:content]

    # Populates fields in view
    flash[:title] = @title
    flash[:author] = @author
    flash[:content] = @content


    post = Post.new
    post.title = @title
    post.content = @content
    post.author = @author
    post.author_id = session[:current_user_id]
    post.valid?

    # Checks for errors
    if post.errors.empty? then
      post.save(post_params)
      
      redirect_to home_path(:display => 'Your post was created') unless admin?
      redirect_to admin_home_path(:display => 'Your post was created') unless !admin?

    else
      redirect_to post_path(:errors => post.errors.full_messages)
    end
  end


  # Deletes post
 def destroy
    if delete_post_params_exist? then
      @title = params[:title]
      @author = params[:author]
      @content = params[:content]

      Post.where(:title => @title, :author => @author, :content => @content).destroy_all

      redirect_to home_path(:display => "The post '#{@title}' was successfully deleted") unless admin?
      redirect_to admin_home_path(:display => "The post '#{@title}' was successfully deleted") unless !admin?
    
    # If the paramaters are not set
    else
      redirect_to home_path(:display => "Something went wrong. Please try again.") unless admin?
      redirect_to admin_home_path(:display => "Something went wrong. Please try again.") unless !admin?
    end
  end


  # What fields can be saved to Database
  def post_params
    params.permit(:title, :author, :content, :id, :author_id)
  end

end
