class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

   # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed


  def follow(other_customer)
    unless self == other_customer
      self.relationships.find_or_create_by(followed_id: other_customer.id)
    end
  end

  def unfollow(other_customer)
    relationship = self.relationships.find_by(followed_id: other_customer.id)
    relationship.destroy if relationship
  end

  def following?(other_customer)
    self.followings.include?(other_customer)
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def self.search(search,word)
    if search == "forward_match"
      @customer = Customer.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @customer = Customer.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      @customer = Customer.where("name LIKE?","#{word}")
    elsif search == "partial_match"
      @customer = Customer.where("name LIKE?","%#{word}%")
    else
      @customer = Customer.all
    end
  end


  attachment :profile_image
  validates :name, presence: true,uniqueness: true
  validates :name,    length: { in: 2..20 }
end
