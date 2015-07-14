FactoryGirl.define do

  factory :user do
   	username									'FooFighter'
    password									'121096H7'
    password_confirmation 		'121096H7'
    admin											false
    superadmin								false
    id												1
  end
  
end