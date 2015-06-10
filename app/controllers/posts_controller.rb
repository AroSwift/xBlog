class PostsController < ApplicationController

  def new
    @post = Post.new
  end


  def update
    # This is for forms
    @ptitle = params[:posts][:ptitle]
    @pcontent = params[:posts][:pcontent]
    # This is for the database
    #@datatitle = params[:datatitle]
    #@datacontent = params[:datacontent]
    @id = params[:id]

    post = Post.new

    #Post.update(@id, title: @ptitle, content: @pcontent)
    post = Post.find_by(@id)
    post.title = @ptitle
    post.content = @pcontent
    post.author = session[:current_username]
    post.id = @id
    post.valid?
    post.save

    if post.errors.empty? then
    flash[:error] = 'Your post was updated'
    redirect_to :home
    else
    flash[:error] = "Your post was not updated. Try again. #{post.errors.full_messages}"
    redirect_to edit_post_path(:ptitle => @ptitle, :pauthor => session[:current_username], :pcontent => @pcontent, :id => @id)
    end
  end



  def create
    @title = params[:posts][:title]
    @author = params[:posts][:author]
    @content = params[:posts][:content]

    flash[:title] = @title
    flash[:author] = @author
    flash[:content] = @content


    if @title.length < 3 then

      flash[:error] = 'The title must be at least 3 characters'
      redirect_to :back
    elsif @title.length > 50 then

      flash[:error] = 'The title must not be more than 50 characters'
      redirect_to :back
    elsif @author.length < 5 then

      flash[:error] = 'The author must be at least 5 characters'
      redirect_to :back
    elsif @author.length > 12 then

      flash[:error] = 'The author must not be more than 12 characters'
      redirect_to :back

      # CHANGE THE MIN LENGTH LATER...
    elsif @content.length < 20 then

      flash[:error] = "The post must be at least 20 characters"
      redirect_to :back 
    elsif @content.length > 10000 then

      flash[:error] = 'The post must not be more than 10,000 characters'
      redirect_to :back 

    else
      dbtitle = Post.find_by(title: @title)
      if dbtitle.nil? then

          post = Post.create(post_params)
          if(request.post? && post.save)
            flash[:error] = 'Your post was submited'
              redirect_to :home
  		    else
            flash[:error] = 'Your post was not submitted. Try again.'
            redirect_to :back
          end
      else
          flash[:error] = 'That title is already in use'
          redirect_to :back
      end
    end
  end


  def post_params
    params.require(:posts).permit(:title, :author, :content)
  end

 def destroy
    @dtitle = params[:dtitle]
    @dauthor = params[:dauthor]
    @dcontent = params[:dcontent]

    flash[:error] = "The post #{@dtitle} was successfully deleted"
    Post.where(:title => @dtitle, :author => @dauthor, :content => @dcontent).destroy_all
    redirect_to :home
  end


end
