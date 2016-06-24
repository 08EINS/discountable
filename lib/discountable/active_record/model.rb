module Discountable
  module ActiveRecord
    module Model

      # Turns one or more columns into a Percentage type.
      # == Example Usage
      #
      #   class Order < ActiveRecord::Base
      #     percentize :discount1, :discount2, postfix: 'percent'
      #     percentize :tax, validate: { less_or_equal_than: 30 }
      #   end
      #
      #   my_order = Order.new discount1: 10, discount2: 40, tax: 10
      #   my_order.valid?
      #   => # true
      #   my_order.discount1
      #   => # 10
      #   my_order.discount1_percent
      #   => # Percentage<10%>
      #   my_order.tax
      #   => # Percentage<10%>
      #
      #   my_order.tax = Percentage.new 50
      #   my_order.valid?
      #   => # false
      #
      # == Options
      # * <tt>postfix: ''</tt>appends the given postfix for the created attribute readers and writers, default is ''
      # * <tt>validate: true</tt>Validation options for numericality validation. set to false if no validation
      # should be done. Default is {greater_or_equal_than: 0}
      #
      # == Values outside percentage range
      # You can set a value outside the allowed range for Percentage. The accessor then just returns the decimal
      # value without conversion, so validation is possible.
      def percentize(*args)

        _default_options = { postfix: '', validate: {greater_or_equal_than: 0} }

        options = _default_options.merge args.extract_options!
        names = args

        names.each do |name|
          add_percentage_validation name, options[:validate] if options[:validate]
          create_percentage_accessor name, options
        end
      end

      private

      def add_percentage_validation(name, validation_options = true)
        self.send :validates, name, numericality: validation_options
      end

      def create_percentage_accessor(column_name, options)
        define_percentage_reader column_name, options
        define_percentage_writer column_name, options
      end

      def define_percentage_reader(column_name, options)
        method_postfix = options[:postfix].blank? ? '' : "_#{options[:postfix]}"

        self.send :define_method, "#{column_name}#{method_postfix}" do
          attribute_value = read_attribute column_name
          return Percentage.new if attribute_value.nil?

          begin
            Percentage.new attribute_value
          rescue ArgumentError
            attribute_value
          end
        end

      end

      def define_percentage_writer(column_name, options)
        method_postfix = options[:postfix].blank? ? '' : "_#{options[:postfix]}"

        self.send :define_method, "#{column_name}#{method_postfix}=" do |val|
          attribute_value = (val.is_a? Percentage) ? val.amount : val
          write_attribute column_name, attribute_value
        end
      end

    end
  end
end

ActiveRecord::Base.extend Discountable::ActiveRecord::Model