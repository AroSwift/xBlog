require 'spec_helper'
require 'factory_girl'

describe Post do

  let(:post) { FactoryGirl.create(:post) }
  before { @post = post.posts.build( title: "Example title", author: "personbubble", content: "Content here and there" }

  subject { @post }

  it { should respond_to(:title) }
  end

end