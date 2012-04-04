Fabricator(:order, :class_name => Order) do
  billing_method_id { 1 }
  user_id { 1 }
end