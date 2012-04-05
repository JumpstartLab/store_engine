  desc "Import the stock products"
  task :import_stock, [:file] => :environment do |t, args| 
    csv_file = CSV.open(args.file,
                   {:headers => true, :header_converters => :symbol})
    csv_file.each do |line|
      Product.create(title: line[:title], description: line[:description], 
                     price: line[:price].to_f * 100)
    end
  end
