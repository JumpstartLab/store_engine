Fabricator(:order, :class_name => Order) do
  billing_method_id { (rand * 1e7).to_i }
  user_id { (rand * 1e7).to_i }
  status { "pending" }
end