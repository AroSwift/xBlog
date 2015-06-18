FactoryGirl.define :user do |user|
	factory :user do
	  user.name                  "Michael Hartl"
	  user.email                 "mhartl@example.com"
	  user.password              "foobar"
	  user.password_confirmation "foobar"
	end
end