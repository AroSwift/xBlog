class Post < ActiveRecord::Base

	validates :content, presence: true 

	def title_length
		return self.title.length
	end

end




