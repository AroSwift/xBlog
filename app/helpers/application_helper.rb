module ApplicationHelper

	def post_created(time)
		return distance_of_time_in_words_to_now(time) + ' ago'
	end

end
