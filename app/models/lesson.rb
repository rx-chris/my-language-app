class Lesson < ApplicationRecord
  # associations
  belongs_to :curriculum

  has_many :cards, dependent: :destroy

  # validations
  validates :title, :description, :order, presence: true

  # getter methods for filtered cards
  def completed_cards
    cards.where.not(correct: nil)
  end

  def incomplete_cards
    cards.where(correct: nil)
  end

  def correct_cards
    cards.where(correct: true)
  end

  def wrong_cards
    cards.where(correct: false)
  end

  # getter methods for aggregated card properties
  def progress
    cards.empty? ? 0 : completed_cards.length.to_f / cards.length
  end

  def score
    correct = correct_cards
    correct.empty? ? 0 : correct.length.to_f / completed_cards.length
  end
end
