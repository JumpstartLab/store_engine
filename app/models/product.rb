class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories
  attr_accessible :title, :description, :price, :status, :category_ids

  validates :title, presence: :true, uniqueness: { case_sensitive: false }
  validates :description, presence: :true
  validates :status, presence: :true,
                     inclusion: { in: %w(active retired),
                                  message: "%{value} is not a valid status" }
  validates :price, presence: :true,
            :format => { :with => /^\d+??(?:\.\d{0,2})?$/ },
            :numericality => { greater_than: 0 }

  def self.apply_filter(category_id = nil)
    if category_id.nil?
      Product.find_all_by_status('active')
    else
      Category.find(category_id).products.where(status: 'active')
    end
  end

  def retire
    self.update_attributes(status: 'retired')
  end

  def activate
    self.update_attributes(status: 'active')
  end
end
