class User < ActiveRecord::Base
validates :username, :password, presence: true
validates :username, length: { in: 5..12 }
validates :password, length: { in: 8..20 }

user = User.new
user.valid?
user.errors.full_messages

user.errors.empty?
user.save

def create
  @user = User.create[params[:user]]

  if @user.save # .save checks .valid?
    redirect_to :home
  else
    redirect_to :back
  end
end



end