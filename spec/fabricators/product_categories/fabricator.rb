Fabricator(:product_category) do
  product_id { rand(0..5) }
  category_id { rand(0..5) }
end