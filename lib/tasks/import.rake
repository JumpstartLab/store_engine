  desc "Import the stock products"
  task :import_stock, [:file] => :environment do |t, args| 
    csv_file = CSV.open(args.file,
                   {:headers => true, :header_converters => :symbol})
    csv_file.each do |line|
      Product.create(title: line[:title], description: line[:description], 
                     price: line[:price])
    end
  end

  desc "Removes dev and test databases, migrates, and loads seed data"
  task :clean_env do
    dev_db = "db/development.sqlite3"
    test_db = "db/test.sqlite3"
    if File.exists?(dev_db) then File.delete(dev_db) end
    if File.exists?(test_db) then File.delete(test_db) end
    Rake::Task["db:migrate"].invoke
    Rake::Task["import_stock"].invoke("db/stock.csv")

    Rake::Task["db:seed"].invoke
    Rake::Task["db:test:prepare"].invoke
  end

