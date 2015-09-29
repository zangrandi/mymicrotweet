class Notification < ActiveRecord::Base
	belongs_to :sender, foreign_key: :sender_id, class_name: "User"
	belongs_to :receiver, foreign_key: :receiver_id, class_name: "User"

	validates :sender, :receiver, presence: true
	
	scope :unread, -> {
		where(read: false)
	} 

	def self.send_notification(sender, receiver)
		self.create(
			sender: sender,
			receiver: receiver
		)
	end
end
