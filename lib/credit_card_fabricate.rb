# Complement to Faker gem to create credit card number

# Usage:
#  > Faker::CreditCard.visa
#    => "4916287009378994"
#
# Card support:
# visa, master, amex, discover, diners, en_route, jcb, voyager

# Inspired by: http://www.darkcoding.net/credit-card/luhn-formula/
module Faker

  class InexistentCardTypeError < ArgumentError; end

  class CreditCard
    class << self

      def number(type, size = DEFAULT_SIZE)
        raise InexistentCardTypeError unless PREFIXES.include? type
        prefix = PREFIXES[type].sample
        number = prefix.to_s.split(//).map(&:to_i)
        number << rand(0..9) while number.size < size - 1
        number << check_digit(number)
        number.join
      end

      def method_missing(m)
        begin
          number(m)
        rescue InexistentCardTypeError
          super
        end
      end

      def cvv
        rand(100..999)
      end

      def expire_date
        (Time.now + rand(80000000..200000000)).strftime('%m/%y')
      end

      def type
        PREFIXES.keys.sample
      end

      def sample
        type = self.type

        {
          type:        type,
          number:      send(type),
          cvv:         cvv,
          expire_date: expire_date,
        }
      end

      private
        DEFAULT_SIZE = 16

        def check_digit(number)
          sum = 0
          number.reverse.each_with_index do |digit, index|
            # remeber indexes starts with 0!!!
            if index.even?
              digit *= 2
              digit -= 9 if digit > 9
            end
            sum += digit
          end
          ((sum / 10 + 1) * 10 - sum) % 10
        end
    end
    PREFIXES = {
      visa:         [4539, 4556, 4916, 4532, 4929, 40240071, 4485, 4716, 4],
      mastercard:   [51, 52, 53, 54, 55],
      amex:         [34, 37],
      discover:     [6011],
      diners:       [300, 301, 302, 303, 36, 38],
      en_route:     [2014, 2149],
      jcb:          [3088, 3096, 3112, 3158, 3337, 3528],
      voyager:      [8699],
    }

  end
end