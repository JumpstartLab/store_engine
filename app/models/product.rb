class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :photo

  validates :title, :presence => true #:uniqueness => true#, :message => "gg"
  #validates :description, :presence => true
  # validates_numericality_of :price, :only_integer => true, :message => "shouldn't be an int, we'll fix later."

  # def to_param
    #[id, title.downcase.split].join("-")
  # end
end
