class PostsController < ApplicationController

  # User updates post
  def update
    @ptitle = params[:posts][:ptitle]
    @pcontent = params[:posts][:pcontent]
    @id = params[:id]

    post = Post.find_by_id(@id)
    post.title = @ptitle
    post.content = @pcontent
    post.author = session[:current_username]
    post.valid?

    # Checks for errors
    if post.errors.empty? then
      post.save(post_params)
      flash[:error] = 'Your post was updated'
      redirect_to :home
    else
      flash[:error] = post.errors.full_messages
      redirect_to edit_post_path(:ptitle => @ptitle, :pauthor => session[:current_username], :pcontent => @pcontent, :id => @id, :errors => post.errors.full_messages)
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
    @dtitle = params[:dtitle]
    @dauthor = params[:dauthor]
    @dcontent = params[:dcontent]

    Post.where(:title => @dtitle, :author => @dauthor, :content => @dcontent).destroy_all
    redirect_to home_path(:display => "The post #{@dtitle} was successfully deleted")
  end

  def post_params
    params.require(:posts).permit(:title, :author, :content, :id, :author_id)
  end

end
