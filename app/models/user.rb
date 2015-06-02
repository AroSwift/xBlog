class User < ActiveRecord::Base

def create
end

 def user
    create_table :user do |t|
      t.string :username
      t.string :password
    end
  end

end
