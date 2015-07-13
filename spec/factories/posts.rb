FactoryGirl.define do

  factory :post do
    title 			"My Title"
		author 			"FooFighter"
		content 		"Some content always likes to go around and in this general area. Because it needs 30 characters."
		id 					1
		user_id			1
  end

end
