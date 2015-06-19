module ApplicationHelper

	def compare_time(time)
		return distance_of_time_in_words_to_now(time) + ' ago'
	end

end
