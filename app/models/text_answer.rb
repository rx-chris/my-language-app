class TextAnswer < ApplicationRecord
  # associations
  belongs_to :card

  # validations
  validates :model_answer, :cards, presence: true
end
