 class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, through: :line_items
  has_many :order_items
  belongs_to :category


  before_destroy :ensure_not_in_line_item
  
  attr_accessible :title, :description, :price, :photo, :category_id, :retired

  validates :title, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :price, :numericality => true

  private

  def ensure_not_in_line_item
    if line_items.empty? 
      return true
    else 
      errors.add(:base, 'Line Items Present')
      return false
    end
  end

end