class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories
  attr_accessible :title, :description, :price, :status, :category_ids

  validates :title, presence: :true, uniqueness: {case_sensitive: false}
  validates :description, presence: :true
  validates :status, presence: :true
  validates :price, presence: :true,
            :format => { :with => /^\d+??(?:\.\d{0,2})?$/ },
            :numericality => { greater_than: 0 }

  def self.apply_filter(category_id = nil)
    if category_id.nil?
      Product.find_all_by_status('active')
    else
      Product.find_all_by_category_id_and_status(category_id, 'active')
    end
  end
end
