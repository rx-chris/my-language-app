class Lesson < ApplicationRecord
  # associations
  belongs_to :curriculum

  has_many :cards, dependent: :destroy

  # validations
  validates :title, :description, :order, presence: true
end
