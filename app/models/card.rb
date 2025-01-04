class Card < ApplicationRecord
  # constants
  LEARNING = :learning
  TEST = :test

  # associations
  belongs_to :blueprint
  belongs_to :lesson
  has_one :mcq_answer, dependent: :destroy
  has_many :mcq_options, dependent: :destroy
  has_one :text_answer, dependent: :destroy

  # cloudinary attachments
  has_one_attached :image_content
  has_one_attached :audio_content

  # validations
  validates :lesson, :blueprint, presence: true
end
