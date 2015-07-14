FactoryGirl.define do

  factory :request do
		username 				"FooFighter"
		password 				"121096H7"
		user_id 				1
		status 					FALSE
		accepted_by 		""
		rejected_by 		""
  end


 	factory :request_other_user do
		username 				"MannyDanny"
		password 				"121096H7"
		user_id 				2
		status 					true
		accepted_by 		""
		rejected_by 		""
  end

end
