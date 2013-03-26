class Order < ActiveRecord::Base
  attr_accessible :status, :order_item_ids
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  validates :user, presence: true
  validates_associated :order_items
end
