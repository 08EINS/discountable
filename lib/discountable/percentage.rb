class Percentage
  include Comparable

  HUNDRED = ::BigDecimal.new 100

  def initialize(amount = 0, allow_negative_percentage = false)
    initialize_amount(amount, allow_negative_percentage)
  end

  def fractional
    @amount / HUNDRED
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

  def initialize_amount(amount, allow_negative_percentage)
    if amount.is_a? Percentage
      @amount = amount.amount
    else
      @amount = ::BigDecimal.new(amount, 6)
    end
    raise ArgumentError.new "I realy don't know how to correctly handle negative percentages... what should it be supposed to do" if @amount < 0 && !allow_negative_percentage
  end

end