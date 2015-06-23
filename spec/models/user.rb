require 'spec_helper'
require 'factory_girl'

describe User do

  let(:user) { FactoryGirl.create(:user) }
  before { @user = user.users.build( username: "Example User", password: "foobar" }

  subject { @user }

  it { should respond_to(:username) }
	end

end
