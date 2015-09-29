#coding: utf-8

require 'rails_helper'

feature 'Users Profile' do
	scenario "User sees all posts from profile" do
		user = create(:user)
		publisher = create(:user)
		posts = create_list(:post, 5, user: publisher)
		login_as(user)
		visit user_path(publisher)
		expect(page).to have_content publisher.fullname
		expect(page).to have_content publisher.username
		posts.each do |post|
			expect(page).to have_content post.text
		end
	end

	scenario "User follow the user on profile" do
		user = create(:user)
		publisher = create(:user)
		login_as(user)
		visit user_path(publisher)
		first(".btn-follow").click()
		expect(user.publishers).to include publisher
		expect(current_path).to eql(user_path(publisher))
	end

	scenario "User unfollow the user on profile" do
		user = create(:user)
		publisher = create(:user)
		user.add_publisher(publisher)
		login_as(user)
		visit user_path(publisher)
		first(".btn-unfollow").click()
		user.reload
		expect(user.publishers).to_not include publisher
		expect(current_path).to eql(user_path(publisher))
	end

	scenario "User does not see follow btn if it's his profile page" do
		user = create(:user)
		login_as(user)
		visit user_path(user)
		expect(page).to_not have_selector(".btn-follow")
		expect(page).to_not have_selector(".btn-unfollow")
	end
end