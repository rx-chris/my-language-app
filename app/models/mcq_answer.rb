class McqAnswer < ApplicationRecord
  # asscociations
  belongs_to :card
  has_many :mcq_options, through: :card
  belongs_to :user_answer, class_name: "McqOption", optional: true
  belongs_to :model_answer, class_name: "McqOption"

  # validations
  validates :model_answer, :card, presence: true

  # methods
  def correct?
    user_answer&.id == model_answer.id
  end

  def answer!(id)
    update!(user_answer: mcq_options.find_by(id:))
  end

  def model_text_answer
    model_answer.text_content
  end
end
