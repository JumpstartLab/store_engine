Fabricator(:product) do
  title { "Product #{sequence}" }
  description { "This is product #{sequence}" }
  price { 600 }
  image_link { "http://inhabitat.com/wp-content/blogs.dir/1/files/2010/06/iphone4-LEAD.jpg" } 
end