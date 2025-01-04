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

  # methods
  def correct?
    answer.correct?
  end

  def answer!(user_answer)
    answer.answer!(user_answer)
    update!(correct: correct?)
  end

  def reset_answer!
    answer.update!(user_answer: nil)
  end

  def answered?
    !answer.user_answer.nil?
  end

  def model_text_answer
    answer.model_text_answer
  end

  private

  def answer
    self.send(blueprint.answer_type)
  end
end
