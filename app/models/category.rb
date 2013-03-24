class Category < ActiveRecord::Base
  attr_accessible :title
  has_many :products

  validates :title, presence: true, uniqueness: {case_sensitive: false}
end
