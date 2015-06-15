class UsersController < ApplicationController

  def create
    @username = params[:signup][:username]
    @password = params[:signup][:password]
    @confirm_password = params[:signup][:confirm_password]
    flash[:username] = @username
    flash[:password] = @password


    user = User.new
    user.username = @username
    user.password = @password
    user.valid?

    if user.errors.empty? then
      if @password == @confirm_password then

        cname = User.find_by(username: @username)
        if cname.nil? then

          user = User.create(user_params)
          if(request.post? && user.save)
            user.save(user_params)
            flash[:error] = 'Account created.'

            # Create Session
            session[:current_user_id] = user.id
            session[:current_username] = user.username
            redirect_to home_path(:display => 'Your account has been successfully created')

          else
            redirect_to signup_path(:errors => user.errors.full_messages)
          end

        else
          redirect_to signup_path(:display => 'Username already exists')
        end
      else
        redirect_to signup_path(:display => 'The passwords do not match')
      end
    else
      redirect_to signup_path(:errors => user.errors.full_messages)
    end
  end



  def show
    @lusername = params[:login][:lusername]
    @lpassword = params[:login][:lpassword]
    flash[:lusername] = @lusername
    flash[:lpassword] = @lpassword

    user = User.new
    user.username = @lusername
    user.password = @lpassword
    user.valid?

    if user.errors.empty? then
      dbusername = User.find_by(username: @lusername)
      dbpassword = User.find_by(password: @lpassword)

      if !dbusername.nil? && !dbpassword.nil? then

        if user.admin == true then



        else
          session[:current_user_id] = dbusername.id
          session[:current_username] = dbusername.username
          redirect_to :home
        end

      else
        flash[:error] = 'The username and password do not match'
        redirect_to login_path(:errors => user.errors.full_messages)
      end
    else
      redirect_to login_path(:errors => user.errors.full_messages)
    end
  end


  def user_params
    params.require(:signup).permit(:username, :password, :id, :admin)
  end

 def destroy
    @_current_user = session[:current_user_id] = nil
    @_current_user = session[:current_username] = nil    
    redirect_to :home
  end

end
