require 'csv'

desc "Import stock data for database table 'products'"
task :import_stock => :environment do
  filename = 'lib/assets/stock_data.csv'
  file = CSV.open(filename, {:headers => true, :header_converters => :symbol})
  file.each do |line|
    Product.create( :name => line[:title],
                    :description => line[:description],
                    :price => line[:price],
                    :photo => line[:photo_url] )
    # puts line.inspect
  end
end