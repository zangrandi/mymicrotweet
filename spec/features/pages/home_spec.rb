#coding: utf-8

require 'rails_helper'

feature 'Home Page' do
	context "Recent Activity" do
		scenario "User see the last 3 posts created" do
			posts = create_list(:post, 3)
			visit root_path
			posts.each do |post|
				expect(page).to have_content(post.text)
				expect(page).to have_content(post.username)
				expect(page).to have_content(post.user.fullname)
			end
		end
	end

	context "Login" do
		scenario "Success" do
			user = create(:user)
			visit root_path
			fill_in "login_user_email", with: user.email
			fill_in "login_user_password", with: user.password
			click_on "main-login"
			expect(current_path).to eql(feed_posts_path)
		end
		scenario "Failure" do
			visit root_path
			click_on "main-login"
			expect(page).to have_content("Invalid email or password.")
			expect(current_path).to eql(new_user_session_path)
		end
	end

	context "Signup" do
		scenario "Success" do
			visit root_path
			fill_in "user_email", with: "bradpitt@gmail.com"
			fill_in "user_password", with: "123456"
			fill_in "user_username", with: "@bradpitt"
			fill_in "user_fullname", with: "Brad Pitt"
			click_on "main-signup"
			expect(current_path).to eql(feed_posts_path)
			expect(page).to have_content("Welcome! You have signed up successfully.")
		end

		scenario "Failure" do
			visit root_path
			click_on "main-signup"
			expect(current_path).to eql('/users')
			expect(page).to have_content("Email can't be blank")
			expect(page).to have_content("Password can't be blank")
		end
	end
end