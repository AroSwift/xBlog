class User < ActiveRecord::Base
	attr_accessible :username, :password
	has_secure_password
  
  before_save { 
      # Do something before it saves
   }

 def user
    create_table :users do |t|
      t.string :username
      t.string :password
    end
  end

  def add_user(username, password)
  	self.user = username.to_s + password.to_s
  end
	
  def find_user(username, password)
  	self.user = username.to_s + password.to_s
  end

end
