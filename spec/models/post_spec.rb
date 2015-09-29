require 'rails_helper'

RSpec.describe Post, type: :model do
  
	context "#username" do
		it "should return user username with @" do
			post = create(:post)
			expect(post.username).to eql("@#{post.user.username}")
		end
	end

end
