class Post < ActiveRecord::Base
	validates :text, length: { maximum: 140 }
	validates :user_id, presence: true
	belongs_to :user

	def username
		"@#{user.username}"
	end
end
