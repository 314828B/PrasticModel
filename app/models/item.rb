class Item < ApplicationRecord
  belongs_to :genre, optional: true
  belongs_to :customer, optional: true
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :liked_customers, through: :favorites, source: :customer

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  def self.search(search, word)
    if search == "forward_match"
      @item = Item.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @item = Item.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      @item = Item.where("name LIKE?","#{word}")
    elsif search == "partial_match"
      @item = Item.where("name LIKE?","%#{word}%")
    else
      @item = Item.all
    end
  end

  validates :name, presence: true
  validates :introduction, presence: true,length: { maximum: 200 }
  attachment :image
end
