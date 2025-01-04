class TextAnswer < ApplicationRecord
  # associations
  belongs_to :card

  # validations
  validates :model_answer, :card, presence: true

  # methods
  def correct?
    user_answer == model_answer
  end

  def answer!(answer)
    update(user_answer: answer)
  end
end
