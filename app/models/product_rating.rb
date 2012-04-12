class ProductRating < ActiveRecord::Base
  attr_accessible :body, :name, :product, :rating, :user

  belongs_to :user
  belongs_to :product

  validates_presence_of :name, :body, :product
  validates_inclusion_of :rating, :in => 0..5
end
