module StoreEngine
  module TestHelpers
    def validate_not_found(path, method = "get")
      lambda { page.driver.send(method, path) }.should raise_error(ActionController::RoutingError)
    end
  end
end
