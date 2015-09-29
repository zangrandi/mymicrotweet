#coding: utf-8

require 'rails_helper'

feature 'Users List' do
	scenario "User sees all users created" do
		users = create_list(:user, 10)
		visit users_path
		users.each do |user|
			expect(page).to have_content user.fullname
			expect(page).to have_content user.username
		end
	end

	scenario "User follow button and is redirects to register page if not logged in" do
		create_list(:user, 10)
		visit users_path
		first(".btn-follow").click
		expect(current_path).to eql(new_user_registration_path)
	end

	scenario "User follow another one" do
		user = create(:user)
		publisher = create(:user)
		login_as(user)
		visit users_path
		first(".btn-follow").click
		expect(user.publishers).to include publisher
		expect(current_path).to eql(users_path)
		expect(page).to have_selector ".btn-unfollow"
	end

	scenario "User unfollow another one" do
		user = create(:user)
		publisher = create(:user)
		user.add_publisher(publisher)
		login_as(user)
		visit users_path
		first(".btn-unfollow").click
		user.reload
		expect(user.publishers).to_not include publisher
		expect(current_path).to eql(users_path)
		expect(page).to have_selector ".btn-follow"
	end

	scenario "User search for users" do
		create(:user, username: "bradpitt", fullname: "Brad Pitt")
		create(:user, username: "tombrady", fullname: "Tom Brady")
		create(:user, username: "angelinajolie", fullname: "Angelina Jolie")
		visit users_path
		fill_in "search-user-field", with: "brad"
		click_on "btn-search"
		expect(page).to have_content "Brad Pitt"
		expect(page).to have_content "Tom Brady"
		expect(page).to_not have_content "Angelina Jolie"
	end
end