module PostsHelper

	def post_created(time)
		dif = Time.now - time
		dif = dif/3
		#Use this to find the actual seconds to impove acuracy
		#return dif



		if dif < 60 then
			return '1 minute ago'
		elsif dif < 30000 then
			return '30 minutes ago'
		elsif dif < 60000 then
			return '1 hour ago'
		elsif dif < 240000 then
			return '1 day ago'
		elsif dif < 1700000
			return '1 week ago'
		elsif  dif < 70000000
			return '1 month ago'
		end

 
	end

end
