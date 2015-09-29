#coding: utf-8

require 'rails_helper'

feature 'Notifications' do
	scenario "User sees his notifications and they're marked as read" do
		user = create(:user)
		publisher = create(:user)
		user.add_publisher(publisher)
		login_as(publisher)
		visit notifications_user_path(publisher)
		expect(page).to have_content "#{user.fullname} started to follow you."
		expect(publisher.notifications.last.read).to be true
	end
end