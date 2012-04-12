module NavHelper

  def main_navigation
    nav_array = {"Home" => root_path}
    nav_array["Home"] = root_path
    if current_user && current_user.admin
      nav_array["Dashboard"] = dashboard_path 
    end
    if current_user 
      nav_array["Logout"] = logout_path
    else
      nav_array["Login or Signup"] = login_path
    end
    return nav_array
  end

  def dashboard_navigation
    { 
      "Products" => dashboard_path, 
      "Orders" => orders_path, 
      "Categories" => categories_path, 
      "Users" => users_path 
    }
  end
end