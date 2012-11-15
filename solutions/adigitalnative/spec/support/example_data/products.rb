module ExampleData
  module Products
    def create_product(attributes={}, &after_create)
      product = if defined?(Fabricate)
        Fabricate(:product) rescue nil
      end
      product ||= if defined?(Factory)
        Factory(:product) rescue nil
      end
      product ||= begin
        custom_create_product(attributes)
      rescue NoMethodError
        raise NotImplementedError.new("Expected product fabricator, factory, or method 'custom_create_product' to be defined")
      end

      after_create[product] if after_create
      product
    end
  end
end