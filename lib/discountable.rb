require 'bigdecimal'

require 'discountable/version'
require 'discountable/percentage'
require 'discountable/adjustment'

begin
  require 'active_record'
  require 'discountable/active_record/model'
rescue LoadError => e
  # we do not depend on active_record, so just move on
end

module Discountable
end

# Make Discount and Percentage globally available
include Adjustment