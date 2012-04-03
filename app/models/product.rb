class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :photo

  # def to_param
    #[id, title.downcase.split].join("-")
  # end
end
