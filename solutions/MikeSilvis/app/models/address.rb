# Address object w/ city, state, zip, etc -- uses geocoder gem
class Address < ActiveRecord::Base
  attr_accessible :street, :zipcode
  before_validation :geocoder
  belongs_to :user

  validates_presence_of :state

  def geocoder
    result = Geocoder.search("#{street}, #{zipcode}").first
    if result
      self.state = result.state
      self.country = result.country
      self.formatted_address = result.address
    end
  end

end
