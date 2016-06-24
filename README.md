[![Build Status](https://travis-ci.org/stestaub/discountable.svg?branch=master)](https://travis-ci.org/stestaub/discountable)

# Discountable

Easely handle discounts and surcharges on monetary values.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'discountable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install discountable

## Usage

### Use with Rails

There is a tiny extensions for your active record models that allows you to turn a decimal column
into a percentage type, so can then use it for discounts or surcharges without handling the conversion by yourself.

**Example Usage**

```ruby
  class Order < ActiveRecord::Base
    percentize :discount1, :discount2, postfix: 'percent'
    percentize :tax, validate: { less_or_equal_than: 30 }
  end
  
  my_order = Order.new discount1: 10, discount2: 40, tax: 10
  my_order.valid?
  => # true
  my_order.discount1
  => # 10
  my_order.discount1_percent
  => # Percentage<10%>
  my_order.tax
  => # Percentage<10%>
  
  my_order.tax = Percentage.new 50
  my_order.valid?
  => # false
```
**Options**

* <tt>{postfix: ''}</tt>appends the given postfix for the created attribute readers and writers, default is ''
* <tt>{validate: true}</tt>Validation options for numericality validation. set to false if no validation
should be done. Default is {greater_or_equal_than: 0}

**Values outside percentage range**
You can set a value outside the allowed range for Percentage. The accessor then just returns the decimal
value without conversion, so validation is possible.

## Contribute

1. Checkout the repository
2. run `$ bundle`
3. run migration to setup a test database `$ rake db:migrate`
4. check if everithing works `$ spec spec/`
5. Lets code