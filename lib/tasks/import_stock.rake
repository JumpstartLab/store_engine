require 'csv'

# controller name
desc "Loads Products"
task :import_stock => :environment do
  Product.destroy_all
  start_time = Time.now
  filename = File.join(Rails.root, '/public/products_seed.csv')
  failures = []

  CSV.foreach(filename, :headers => true) do |row|
    begin
      # model name
      Product.create!(
        :title       => row[0],
        :description => row[1],
        :price       => row[2],
        :photo_url   => row[3]
        )
    rescue => e
      puts e
      failures << row
    end
  end

  total_time = Time.now - start_time
  puts "Elapsed time #{total_time} seconds."
  puts "Failed to add #{failures.count} products"
  puts failures.inspect
end
