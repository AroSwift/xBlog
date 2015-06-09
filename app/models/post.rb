class Post < ActiveRecord::Base

	validates :title, :author, :content, presence: true 
	validates :title, length: { in: 5..50 }
	validates :content, length: { in: 20..10000 } # Change MIN value later

	def title_length
		return self.title.length
	end

end




