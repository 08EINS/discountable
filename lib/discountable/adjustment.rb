require 'money'
module Adjustment

  class Base
    attr_reader :percentage
    attr_reader :original_price

    def initialize(original_value, percentage)
      @percentage = Percentage.new(percentage)
      @original_price = Money.new(original_value)
    end
  end

  class Surcharge < Base

    def surcharge_price
      original_price * percentage.fractional
    end

    def total_price
      original_price + surcharge_price
    end

  end

  class Discount < Base

    def offprice
      original_price - discounted_price
    end

    def discounted_price
      original_price * percentage.price_factor
    end

  end

end