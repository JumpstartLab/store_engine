class Product < ActiveRecord::Base
  acts_as_paranoid

  validates :photo_url, url: true

  attr_accessible :name, :description, :categories, :category_ids, :photo_url
  attr_accessible :price_in_cents, :price, as: :admin

  has_many :orders
  has_many :product_categories, :dependent => :destroy
  has_many :categories, :through => :product_categories

  monetize :price_in_cents, :target_name => "price"

  def retired?
    retired
  end

  default_scope where(retired: false)
  scope :retired, where(:retired => true)
end
