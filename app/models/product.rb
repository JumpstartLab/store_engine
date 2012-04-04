class Product < ActiveRecord::Base
  attr_accessible :title, :description,
    :price, :photo, :category_id, :retired

  belongs_to :category

  validates_presence_of :title, :description

  def self.active
    where(:retired => false)
  end

  def active?
    !retired
  end
end
