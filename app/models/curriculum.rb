class Curriculum < ApplicationRecord
  # associations
  belongs_to :language
  belongs_to :user

  has_many :lessons, dependent: :destroy
  has_many :cards, through: :lessons
  has_many :selected_card_blueprints, dependent: :destroy

  # validations
  validates :title, :purpose, :start_date, :end_date, :context, presence: true
  # validates :selected_card_blueprints, length: { minimum: 1, too_short: "need to have at least 1 selected card blueprint" }
end
