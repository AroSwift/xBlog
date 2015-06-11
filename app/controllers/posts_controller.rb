class PostsController < ApplicationController

  def new
    @post = Post.new
  end


  def update
    @ptitle = params[:edit_posts][:ptitle]
    @pcontent = params[:edit_posts][:pcontent]
    @id = params[:id]

    #Post.where(:id => @id).limit(1).update_all(title: @ptitle, content: @pcontent, id: @id)
    #redirect_to :home

    post = Post.find_by_id(@id)
    post.title = @ptitle
    post.content = @pcontent
    post.author = session[:current_username]
    post.valid?
    post.save

    if post.errors.empty? then
      flash[:error] = 'Your post was updated'
      redirect_to :home
    else
      flash[:error] = post.errors.full_messages
      redirect_to edit_post_path(:ptitle => @ptitle, :pauthor => session[:current_username], :pcontent => @pcontent, :id => @id, :errors => post.errors.full_messages)
    end
  end



  def create
    @title = params[:posts][:title]
    @author = params[:posts][:author]
    @content = params[:posts][:content]

    flash[:title] = @title
    flash[:author] = @author
    flash[:content] = @content


    post = Post.new
    post.title = @title
    post.content = @content
    post.author = @author
    #post.admin = false
    post.valid?
    post.save


    if post.errors.empty? then
      flash[:error] = 'Your post was updated'
      redirect_to :home
    else
      flash[:error] = post.errors.full_messages
      redirect_to post_path(:errors => post.errors.full_messages)
    end
  end


  def post_params
    params.require(:posts).permit(:title, :author, :content, :admin, :id)
  end

  def update_post_params
    params.require(:edit_posts).permit(:title, :author, :content, :admin, :id)
  end

 def destroy
    @dtitle = params[:dtitle]
    @dauthor = params[:dauthor]
    @dcontent = params[:dcontent]

    flash[:errors] = "The post #{@dtitle} was successfully deleted"
    Post.where(:title => @dtitle, :author => @dauthor, :content => @dcontent).destroy_all
    redirect_to :home
  end


end
