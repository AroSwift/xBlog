class Users < ActiveRecord::Base

 def user
    create_table :users do |t|
      t.string :username
      t.string :password
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end
	
end
