module StoreEngine
  module TestHelpers
    #def validate_not_found(path)
      #lambda { visit path }.should raise_error(ActionController::RoutingError)
    #end

    #def validate_post_not_found(path)
      #lambda { page.driver.post(path(model)).should raise_error(ActionController::RoutingError)}
    #end

    #def validate_put_not_found(path)
      #lambda { page.driver.put(path(model) }.should raise_error(ActionController::RoutingError)
    #end

    def validate_not_found(path, method = "get")
      lambda { page.driver.send(method, path) }.should raise_error(ActionController::RoutingError)
    end
    private
  end
end
