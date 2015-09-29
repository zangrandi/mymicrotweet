#coding: utf-8

require 'rails_helper'

feature 'Feed Page' do
	context "Activity Feed" do
		scenario "User see his posts and the ones from the publishers" do
			user = create(:user)
			publisher = create(:user)
			user.add_publisher(publisher)

			own_posts = create_list(:post, 3, user: user)
			publisher_posts = create_list(:post, 3, user: publisher)
			posts = own_posts + publisher_posts

			login_as(user)

			visit feed_posts_path

			posts.each do |post|
				expect(page).to have_content(post.text)
				expect(page).to have_content(post.username)
				expect(page).to have_content(post.user.fullname)
			end
		end

		scenario "User create post" do
			user = create(:user)
			login_as(user)
			visit feed_posts_path
			fill_in "post_text", with: "Hello World"
			expect {
				click_on "post-btn"
			}.to change(Post, :count).by(1)
			post = Post.last
			within("#posts") do
				expect(page).to have_content(post.text)
				expect(page).to have_content(post.username)
			end
		end
	end
end