class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :posts, dependent: :destroy
  has_many :publishers, foreign_key: :publisher_id, class_name: "User"
  has_many :publishers_posts, through: :publishers, source: :posts
  has_many :notifications, foreign_key: :receiver_id, dependent: :destroy
  
  validates :username, :fullname, presence: true
  validates :username, uniqueness: true

  def add_publisher(user)
  	self.publishers << user
    Notification.send_notification(self, user)
  end

  def feed_posts
  	(self.posts + self.publishers_posts).sort_by(&:created_at).reverse
  end

  def to_param
    self.username
  end
end
