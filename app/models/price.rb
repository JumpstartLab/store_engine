module StoreEngine
  module Price
    def price
      money = self[:price_cents].to_i
      Money.new(money, "USD")
    end

    def price=(price_string)
      if price_string.include?(".")
        price_cents = price_string.gsub(".", "").to_i
      else
        price_cents = "#{price_string}00".to_i
      end
      self[:price_cents] = price_cents
    end
  end
end
