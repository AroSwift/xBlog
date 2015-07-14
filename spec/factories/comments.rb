FactoryGirl.define do
	
  factory :comment do
	  comment 		"My very amazing comment"
		post_id 		1
		user_id			1
		user 				"FooFighter"
  end

end
