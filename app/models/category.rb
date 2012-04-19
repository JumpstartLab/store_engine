class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :product_categories
  has_many :products, :through => :product_categories
  belongs_to :sale

  def on_sale?
    if sale && sale.endtime >= Time.now
      true
    else
      false
    end
  end
end
