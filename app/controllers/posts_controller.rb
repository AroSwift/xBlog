class PostsController < ApplicationController

  # Updates Post
  def update
    @ptitle = params[:posts][:title]
    @pcontent = params[:posts][:content]
    @id = params[:id]

    post = Post.find_by_id(@id)
    post.title = @title
    post.content = @content
    post.author = session[:current_username]
    post.valid?

    # Checks for errors
    if post.errors.empty? then
      post.save(post_params)
      flash[:error] = 'Your post was updated'
      redirect_to :home
    else
      flash[:error] = post.errors.full_messages
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
      redirect_to :home
    else
      flash[:error] = post.errors.full_messages
      redirect_to post_path(:errors => post.errors.full_messages)
    end
  end

  # Deletes user
 def destroy
    @title = params[:title]
    @author = params[:author]
    @content = params[:content]

    Post.where(:title => @title, :author => @author, :content => @content).destroy_all
    redirect_to home_path(:display => "The post '#{@title}' was successfully deleted")
  end

  # What fields can be saved to Database
  def post_params
    params.require(:posts).permit(:title, :author, :content, :id, :author_id)
  end

end
