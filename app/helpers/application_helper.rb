module ApplicationHelper

	def compare_time(time)
		return distance_of_time_in_words_to_now(time) + ' ago'
	end

	def check_admin(user)
		u = User.where(username: user)
		if u.admin == 't' then
			return 1
		else
			return 0
		end
	end

end
