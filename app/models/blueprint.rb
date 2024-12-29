class Blueprint < ApplicationRecord
  # enums
  enum :input_type, [ :text, :mcq ]
  enum :content_type, [ :text_content, :audio_content, :image_content ]

  # association
  has_many :cards, dependent: :destroy

  # validations
  validates :name, :instruction, presence: true
end
