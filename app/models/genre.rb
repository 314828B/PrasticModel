class Genre < ApplicationRecord
  has_many :items

  validates :name, presence: true
  validates :name, length: { maximum: 20 }
end
