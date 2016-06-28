class Percentage
  include Comparable

  def initialize(amount = 0)
    initialize_amount amount
    @hundred = ::BigDecimal.new 100
  end

  def fractional
    @amount / @hundred
  end

  def amount
    @amount
  end

  # The factor that would apply if discounting a price
  # @return [BigDecimal]
  def price_factor
    ::BigDecimal.new(1) - fractional
  end

  def as_json
    self.amount
  end

  def to_s
    "#{@amount}%"
  end

  # Discount is compared on the amount
  def <=>(other)
    _other = other.is_a?(Percentage) ? other.amount : other
    amount <=> _other
  end

  def inspect
    "#{self.class.name}<#{to_s}>"
  end

  def to_f
    @amount.to_f
  end

  private

  def initialize_amount(amount)
    if amount.is_a? Percentage
      @amount = amount.amount
    else
      @amount = ::BigDecimal.new(amount, 6)
    end
    raise ArgumentError.new "I realy don't know how to correctly handle negative percentages... what should it be supposed to do" if @amount < 0
  end

end