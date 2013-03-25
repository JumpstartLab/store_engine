class Category < ActiveRecord::Base
  attr_accessible :title, :product_ids
  has_and_belongs_to_many :products

  validates :title, presence: true,
                    uniqueness: {case_sensitive: false}
end
