 class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :photo

  validates :title, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :price, :numericality => true#, :message=> "message!"

end