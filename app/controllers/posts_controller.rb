class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def show



  end

  def create

    @title = params[:posts][:title]
    @author = params[:posts][:author]
    @content = params[:posts][:content]


    if @title.length < 3 then

      flash[:error] = 'The title must be at least 3 characters'
      redirect_to :back
    elsif @title.length > 40 then

      flash[:error] = 'The title must not be more than 40 characters'
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
    elsif @content.length > 5000 then

      flash[:error] = 'The post must not be more than 5000 characters'
      redirect_to :back 


    else
      # DATABASE STUFF AFTER ALL CONDITIONS MEET

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
    # Logout
    @_current_user = session[:current_user_id] = nil
    @_current_user = session[:current_username] = nil    
    redirect_to :home
  end


end
