class Curriculum < ApplicationRecord
  # associations
  belongs_to :language
  belongs_to :user

  has_many :lessons, dependent: :destroy
  has_many :cards, through: :lessons
  has_many :selected_card_blueprints, dependent: :destroy

  # validations
  validates :title, :purpose, :start_date, :end_date, presence: true

  # methods
  def progress
    lessons.empty? ? 0 : lessons.sum { |lesson| lesson.progress }.to_f / lessons.length
  end

  def score
    lessons.empty? ? 0 : lessons.sum { |lesson| lesson.score }.to_f / lessons.length
  end
end
