class Language < ApplicationRecord
  # associations
  has_many :curricula, dependent: :destroy

  # validations
  validates :name, presence: true
end
