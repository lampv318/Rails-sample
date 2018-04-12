class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true

 scope :search_followed_id, -> user_id {
    where( follower_id: user_id ).select("followed_id")
  }

end
