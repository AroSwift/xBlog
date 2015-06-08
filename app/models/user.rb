class User < ActiveRecord::Base
validates :username, :password, presence: true
end

User.create(username: @username).valid?