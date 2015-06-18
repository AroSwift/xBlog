FactoryGirl.define do
  factory :user, :class => 'User' do
    username 'abcdefghijklmnopqrstuvwxyz'
    password '12345678'
    password_confirmation '12345678'
  end
end