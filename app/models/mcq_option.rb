class McqOption < ApplicationRecord
  # associations
  belongs_to :card

  # cloudinary attachments
  has_one_attached :picture_context
  has_one_attached :audio_context
end
