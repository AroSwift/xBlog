class User < ActiveRecord::Base

 	before_save :super_admin

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :requests, dependent: :destroy

	# Validates characteristics of user
	validates :username, uniqueness: true
	validates :username, :password, presence: true
	validates :username, length: { in: 5..12 }
	validates :password, length: { in: 8..20 }
	# has_secure_password


	# validates password == password_confirmation
	validates_presence_of :password_confirmation, on: :create
	validates_confirmation_of :password, on: :create


	# ####### # # # # # # # ### # # # ## # # 
	### # # # # # # # # # # ##    Fat model begins here:


  def self.search(search)
    if search
      where('username LIKE ?', "%#{search}%")
    else
      scoped
    end
  end


private

  def super_admin
    self.admin = true if self.superadmin == true
  end

end