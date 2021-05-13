class Comment < ApplicationRecord
   belongs_to :customer
  belongs_to :ite
  validates :comment, presence: true
end
