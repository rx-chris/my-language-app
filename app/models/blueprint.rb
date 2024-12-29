class Blueprint < ApplicationRecord
  # association
  has_many :cards, dependent: :destroy

  # validations
  validates :name, :instruction, presence: true
end
