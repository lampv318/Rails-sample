class Image < ApplicationRecord
  belongs_to :post

  mount_uploader  :link, ImageUploader
end
