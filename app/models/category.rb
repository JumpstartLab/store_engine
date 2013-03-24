class Category < ActiveRecord::Base
  attr_accessible :title

  validates :title, presence: :true, uniqueness: :true

  has_many :products

  validates :title, presence: true, uniqueness: {case_sensitive: false}
end
