Fabricator(:order) do
  user_id 1
  status ["pending", "cancelled", "paid", "shipped", "returned"].sample
end
