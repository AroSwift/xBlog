class Users < ActiveRecord::Base

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
