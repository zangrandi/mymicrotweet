require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { create(:user) }
	let(:publisher) { create(:user) }

	context "#add_publisher" do
		it "should add publisher to user" do
			user.add_publisher(publisher)
			expect(user.publishers).to include publisher
		end

		it "should send notification to user" do
			Notification.should_receive(:send_notification).with(user, publisher)
			user.add_publisher(publisher)
		end
	end

	context "#feed_posts" do
		it "should return user posts plus his publishers posts in reverse order" do
			user.add_publisher(publisher)
			posts = create_list(:post, 3, user: user)
			publisher_posts = create_list(:post, 3, user: publisher)
			another_posts = create_list(:post, 3, user: user)
			expect(user.feed_posts).to eql((posts + publisher_posts + another_posts).reverse)
		end
	end
end
