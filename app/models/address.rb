class Address < ActiveRecord::Base
  attr_accessible :street, :zipcode
  before_save :geocoder
  belongs_to :user

  def geocoder
    g = Geocoder.search("#{street}, #{zipcode}").first
    self.state = g.state
    self.country = g.country
    self.formatted_address = g.formatted_address
  end
  
end
