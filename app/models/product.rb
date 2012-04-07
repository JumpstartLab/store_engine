class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :photo_url, :category_ids
  has_many :product_categorizations
  has_many :categories, :through => :product_categorizations
  has_many :line_items

  validates_presence_of :title, :description, :price
  validates_uniqueness_of :title
  validates_numericality_of :price
  validates_format_of :photo_url, with: /^https?:\/\/(?:[a-z\-]+\.)+[a-z]{2,6}(?:\/[^\/#?]+)+\.(?:jpg|gif|png|jpeg)$/,
  allow_nil: true, unless: Proc.new { |p| p.photo_url.blank? }

  def to_param
    [id, title.downcase.split(" ")].join("-")
  end

  def display_price
    BigDecimal.new(price.to_s,2)
  end

  def create_new_category(params)
    raise params.inspect
  end

  def category_ids=(params)
    self.categories = []
    params.each do |id|
      unless id.to_s.empty?
        category = Category.find(id)
        categories << category
      end
      save
    end
  end



end
