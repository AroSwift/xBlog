class User < ActiveRecord::Base

def change
end

def create
end

 def users
    create_table :users do |t|
      t.string :username
      t.string :password
    end
  end

end

