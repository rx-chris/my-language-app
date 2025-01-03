class McqAnswer < ApplicationRecord
  # asscociations
  belongs_to :card
  has_many :mcq_options, through: :cards
  belongs_to :user_answer, class_name: "McqOption"
  belongs_to :model_answer, class_name: "McqOption"

  # validations
  validates :model_answer, :cards, presence: true
end
