class Post < ActiveRecord::Base

	validates :title, :author, :content, presence: true 

	def title_length
		return self.title.length
	end

end




