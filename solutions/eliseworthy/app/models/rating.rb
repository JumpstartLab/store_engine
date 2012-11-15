class Rating
  attr_accessor :rating

  def initialize(product_upc)
    @rating = fetch_and_parse_rating(product_upc)
  end

  def fetch_and_parse_rating(product_upc)
    response = RatingFetcher.fetch(product_upc)
    item = response.parsed_response['goodguide_response']['entities']['entity']
    if item.instance_of? Array
      item.first
    else
      item
    end
  end

  def to_html
    rating['small_badge_html'] if rating
  end
end

class RatingFetcher
  include HTTParty

  base_uri 'http://api.goodguide.com/'

  def self.fetch(upc)
    tries_left = 3
    begin
      options = {
        api_key: "5pa4ewzvcq85ycbzurschy4d",
        api_version: "1.0",
        api_format: "badge",
        upc: upc
      }
      self.get("/search.xml", query: options)
    rescue
      tries_left -= 1
      retry if tries_left > 0
    ensure
      nil
    end
  end
end