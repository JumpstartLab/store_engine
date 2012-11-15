# A generic label for multiple products
class Category < ActiveRecord::Base
  attr_accessible :name, :product_ids
  default_scope :conditions => { :active => 1 }

  has_many :category_products
  has_many :products, :through => :category_products
  belongs_to :sale
  validates_presence_of :name

  def destroy
    self.active = 0
    self.save
  end
end
