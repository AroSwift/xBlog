class Post < ActiveRecord::Base

	validates :title, presence: true 
	validates :author, presence: true 
	validates :content, presence: true 
	validates :title, length: { in: 5..50 }
	validates :content, length: { in: 20..10000 } # Change MIN value later

end




