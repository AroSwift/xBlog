module ApplicationHelper

	def compare_time(time)
		return distance_of_time_in_words_to_now(time) + ' ago'
	end

	def check_admin(user)
		# true means user is admin, but not another admin
		u = User.find_by_username(user)
		if u.username == session[:current_username] then
			return true
		elsif u.admin == 't' || u.admin == true then 
			return false
		else
			return true
		end
	end

end
