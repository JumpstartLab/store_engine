CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

require 'csv'

task :import_stock => :environment do
  file_path = ENV['file_path']
  begin
    #file_name = "/Users/andrewglass/Documents/store_engine/importtest.csv"
    file = CSV.open(file_path, CSV_OPTIONS)
    pre_count = Product.all.length
    file.each do |line|
      Product.create(
        :title => line[:title],
        :description => line[:description],
        :price => line[:price],
        :photo => line[:photo_url])
    end
    puts "loaded #{Product.all.length - pre_count}  new products"
  rescue
    puts "couldnt find that file. maybe check your pockets?"
  end
end
