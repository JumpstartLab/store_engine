 class Product < ActiveRecord::Base
  include HTTParty
  base_uri 'http://api.goodguide.com/'
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
    case retired
    when true then false
    when false then true
    end
  end

  def badge_html
    begin
      response = retrieve_rating
      if response.success?
        e = response.parsed_response["goodguide_response"]['entities']['entity']
        if e.instance_of? Array
          e.first['small_badge_html']
        else
          e['small_badge_html']
        end
      end
    rescue
      nil
    end
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

  def retrieve_rating
    options = {
      api_key: "5pa4ewzvcq85ycbzurschy4d",
      api_version: "1.0",
      api_format: "badge",
      upc: upc
    }
    Product.get("/search.xml", query: options)
  end

end