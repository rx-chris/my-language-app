class Card < ApplicationRecord
  # associations
  belongs_to :blueprint
  belongs_to :lesson
  has_many :mcq_options, dependent: :destroy

  # cloudinary attachments
  has_one_attached :picture_content
  has_one_attached :audio_content

  # validations
  validates :instruction, :model_answer, presence: true
end
