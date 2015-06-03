class User < ActiveRecord::Base

	has_many :users


def create
end

def show
end

 def user
    create_table :users do |t|
      t.string :username
      t.string :password
    end
  end


end
