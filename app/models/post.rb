class Post < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :user

  scope :by_default, lambda { order created_at: :desc }

  scope :search_post, -> user_id {
    following_ids = Relationship.search_followed_id user_id
    where(" user_id IN (:following_ids) OR user_id = :user_id ",following_ids: following_ids,
      user_id: user_id)
  }
  accepts_nested_attributes_for :images, allow_destroy: true
end
