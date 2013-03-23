class Product < ActiveRecord::Base
  belongs_to :category
  attr_accessible :title, :category_id, :description, :price, :status

  validates :title, presence: :true, uniqueness: :true
  validates :description, presence: :true
  validates :status, presence: :true
  validates :price, presence: :true, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, numericality: { greater_than: 0 }

  def self.active_products
    Product.find_all_by_status('active')
  end

end
