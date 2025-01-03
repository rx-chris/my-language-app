class Blueprint < ApplicationRecord
  # enums
  enum :input_type, [ :text_answer, :mcq_answer ]
  enum :content_type, [ :text_content, :audio_content, :image_content ]

  # association
  has_many :cards, dependent: :destroy

  # validations
  validates :name, presence: true, uniqueness: true
  validates :instruction, presence: true
end
