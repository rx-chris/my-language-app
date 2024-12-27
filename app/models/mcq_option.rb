class McqOption < ApplicationRecord
  # associations
  belongs_to :card

  # cloudinary attachments
  has_one_attached :picture_content
  has_one_attached :audio_content
end
