FactoryGirl.define do

  factory :post do |post|
    post.title			'Good Times'
    post.post			'Post Content'
    post.author			'Author'
    post.author_id 		1
  end

end
