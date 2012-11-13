module ExampleData
  module Projects
    def create_product(attributes={}, &after_create)
      product = if defined?(Fabricate)
        Fabricate(:product)
      elsif defined?(Factory)
        Factory(:product)
      else
        begin
          custom_create_product(attributes)
        rescue NoMethodError
          raise NotImplementedError.new("Expected product fabricator, factory, or method `custom_create_product' to be defined")
        end
      end

      after_create[product] if after_create
      product
    end
  end
end
