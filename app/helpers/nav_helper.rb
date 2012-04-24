module NavHelper

  def main_navigation
    if current_user && current_user.admin
      nav_array_admin
    elsif current_user
      nav_array_user
    else
      nav_guest
    end
  end

  def nav_array_admin
    {
      "Home" => root_path,
      "Cart" => cart_path,
      "Sales" => sales_path,
      "Dashboard" => dashboard_path,
      "My Orders" => my_orders_orders_path,
      "Logout" => logout_path
    }
  end

  def nav_array_user
    {
      "Home" => root_path,
      "Cart" => cart_path,
      "Sales" => sales_path,
      "My Orders" => my_orders_orders_path,
      "Logout" => logout_path
    }
  end

  def nav_guest
    {
      "Home" => root_path,
      "Cart" => cart_path,
      "Sales" => sales_path,
      "Login or Signup" => login_path
    }
  end

  def dashboard_navigation
    {
      "Products" => admin_products_path,
      "Orders" => admin_orders_path,
      "Categories" => admin_categories_path,
      "Users" => admin_users_path,
      "Sales" => admin_sales_path
    }
  end
end