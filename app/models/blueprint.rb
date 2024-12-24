class Blueprint < ApplicationRecord
  # association
  has_many :cards, dependent: :destroy

  # validations
  validates :name, presence: true
end
