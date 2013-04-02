class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :status, :category_ids, :image
  has_and_belongs_to_many :categories
  has_attached_file :image, styles: { medium: "400x400!", thumb: "200x200!" }

  validates :title, presence: :true,
                    uniqueness: { case_sensitive: false }
  validates :description, presence: :true
  validates :status, presence: :true,
                     inclusion: { in: %w(active retired) }
  validates :price, presence: :true,
                    format: { with: /^\d+??(?:\.\d{0,2})?$/ },
                    numericality: { greater_than: 0 }

  def retire
    self.update_attributes(status: 'retired')
  end

  def activate
    self.update_attributes(status: 'active')
  end

  def on_sale?
    percent_off > 0
  end

  def sale_price
    price - discount
  end

  def discount
    price * (BigDecimal.new(percent_off) / 100)
  end

  def percent_off
    product_sales = Sale.where(group: 'product').where(status: 'active').where(foreign_key: self.id)
    percent_of_product = product_sales.present? ? product_sales.map { |product_sale| product_sale.percent_off }.inject(&:+) : 0
    if category_ids.present?
      category_sales = Sale.where(group: 'category').where(status: 'active').where(foreign_key: category_ids)
      percent_of_category = category_sales.present? ? category_sales.map { |product_sale| product_sale.percent_off }.inject(&:+) : 0
    end
    category_ids.present? ? percent_of_product + percent_of_category : percent_of_product
  end
end
