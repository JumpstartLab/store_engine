class Product < ActiveRecord::Base
  acts_as_paranoid

  attr_accessible :name, :description, :categories, :category_ids
  attr_accessible :price_in_cents, :price, as: :admin

  has_many :orders
  has_many :product_categories, :dependent => :destroy
  has_many :categories, :through => :product_categories

  validates_presence_of :title, :description
  validates_uniqueness_of :title
  validates_numericality_of :price_in_cents

  monetize :price_in_cents, :target_name => "price"

  def retired?
    retired
  end

  default_scope where(retired: false)
  scope :retired, where(:retired => true)
end
