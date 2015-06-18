class PostsController < ApplicationController

  include UsersHelper

  # Updates Post
  def update
    @title = params[:posts][:title]
    @content = params[:posts][:content]
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
      flash[:error] = 'Your post was updated'

      if admin? then
        redirect_to :admin_home
      else
        redirect_to :home
      end

    else
      redirect_to edit_post_path(:title => @title, :author => session[:current_username], :content => @content, :id => @id, :errors => post.errors.full_messages)
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
      flash[:error] = 'Your post was updated'
      
      if admin? then
        redirect_to :admin_home
      else
        redirect_to :home
      end

    else
      redirect_to post_path(:errors => post.errors.full_messages)
    end
  end


  # ADDING COMMENTING FUNCTIONALITY
  def comment
    @comment = params[:comment]
    @post_id = params[:post_id]

    com = Comment.new
    com.comment = @comment
    com.post_id = @post_id
    com.user = session[:current_username]
    com.valid?


    if com.errors.empty? then
      com.save(comment_params)
      flash[:error] = 'Your post was updated'
      
      if admin? then
        redirect_to :admin_home
      else
        redirect_to :home
      end

    else
      if admin?
        redirect_to admin_home_path(:errors => com.errors.full_messages)
      else
        redirect_to home_path(:errors => com.errors.full_messages)
      end
    end
  end


  # Deletes user
 def destroy
    @title = params[:title]
    @author = params[:author]
    @content = params[:content]

    Post.where(:title => @title, :author => @author, :content => @content).destroy_all

      
      if admin? then
        redirect_to admin_home_path(:display => "The post '#{@title}' was successfully deleted")
      else
        redirect_to home_path(:display => "The post '#{@title}' was successfully deleted")
      end
  end

  # What fields can be saved to Database
  def post_params
    params.require(:posts).permit(:title, :author, :content, :id, :author_id)
  end

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user)
  end

end
