class Post < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :user

  default_scope -> { order created_at: :desc }

  accepts_nested_attributes_for :images, allow_destroy: true
end
