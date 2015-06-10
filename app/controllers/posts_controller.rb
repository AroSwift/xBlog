class PostsController < ApplicationController

  def new
    @post = Post.new
  end


  # THIS REQUIRES WORK
  def update

    if flash[:ptitle].present? && flash[:pcontent].present? then
      @ptitle   = flash[:ptitle]
      @pcontent = flash[:pcontent]
    elsif params[:posts][:ptitle].present? && params[:posts][:pcontent].present? then
      @ptitle   = params[:posts][:ptitle]
      @pcontent = params[:posts][:pcontent]
    end
    pst = Post.new
    flash[:ptitle] = @ptitle
    flash[:pcontent] = @pcontent
    flash[:otitle] = @otitle
    @otitle = flash[:otitle]

    #Post.create(title: @title, author: @pauthor, content: @pcontent).valid?

    post = Post.find_by(title: @ptitle, author: session[:current_username])


    if pst.errors.empty? then
      #Post.where(title: @otitle, author: session[:current_username]).update_all(title: @ptitle, author: session[:current_username], content: @pcontent)
      pst.save

        if pst.save
        flash[:error] = 'Your post was updated'
        redirect_to :home
        else
        flash[:error] = 'Your post was not updated. Try again.'
        redirect_to :edit_post
        end

    else
      flash[:error] = pst.errors.full_messages
      redirect_to :edit_post
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
