class Address < ActiveRecord::Base
  attr_accessible :street, :zipcode
  before_validation :geocoder
  belongs_to :user

  validates_presence_of :state

  def geocoder
    g = Geocoder.search("#{street}, #{zipcode}").first
    if g
      self.state = g.state
      self.country = g.country
      self.formatted_address = g.formatted_address
    end
  end
  
end
