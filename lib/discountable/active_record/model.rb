module Discountable

  module ActiveRecord

    module Model

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

          if (attribute_value > 0) && (attribute_value < 100)
            Percentage.new attribute_value
          else
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