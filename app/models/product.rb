class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :image,
                  :remote_image_url, :remove_image,
                  :retired, :category_ids


  validates :title,       :presence => true

  validates :description, :presence => true

  validates :price,       :presence => true,
                          :numericality => {
                            :greater_than => 0
                          }
  validates_format_of :remote_image_url, :allow_blank => true,
  :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  has_many :orders
  has_many :cart_products

  has_many :product_categories
  has_many :categories, :through => :product_categories

  has_many :retirements
  has_many :activations
  belongs_to :sale

  mount_uploader :image, ImageUploader

  def self.active
    where(:retired => false)
  end

  def self.retired
    where(:retired => true)
  end

  def self.search(search)
    if search
      find(:all,
           :conditions => ["title LIKE ? and retired=?", "%#{search}%", false])
    else
      find(:all, :conditions => ["retired=?", false])
    end
  end

  def retire
    self.retirements << Retirement.new
    self.retired = true
    if save
      self.cart_products.each do |cp|
        cp.destroy
      end
    end
  end

  def activate
    self.activations << Activation.new
    self.retired = false
    save
  end

  def retired_at
    if self.retired
      self.retirements.last.created_at
    else
      nil
    end
  end

  def on_sale?
    if sale && sale.endtime >= Time.now
      true
    elsif sale_categories.any?
      true
    else
      false
    end
  end

  def sale_categories
    categories.select do |category|
      category.on_sale?
    end
  end

  def cheapest_category
    if sale_categories.any?
      sale_categories.max_by do |cat|
        cat.sale.percentage
      end
    else
      nil
    end
  end

  def category_sale_price
    if cheapest_category
      self.price * (1 - cheapest_category.sale.percentage/100.0)
    else
      self.price
    end
  end

  def sale_price
    if on_sale? && sale
      self.price * (1 - sale.percentage/100.0)
    else
      self.price
    end
  end

  def best_price
    if sale_price < category_sale_price
      return sale_price
    elsif category_sale_price < sale_price
      return category_sale_price
    else
      return self.price
    end
  end

end
