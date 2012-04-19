 class Product < ActiveRecord::Base
  has_many :line_items
  has_many :category_assignments
  has_many :categories, through: :category_assignments
  has_many :order_items

  before_destroy :ensure_not_in_line_item

  attr_accessible :title,
                  :description, :price, :photo,
                  :category_id, :category_ids,
                  :retired, :id, :upc

  validates :title, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :price, :presence => true
  validates_numericality_of :price, :greater_than => 0

  def category_list
    categories.map(&:name).join(", ")
  end

  def retired_switch
    !retired
  end

  def badge_html
    Rating.new(upc).to_html
  end

#  private

  def ensure_not_in_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items Present')
      return false
    end
  end
end