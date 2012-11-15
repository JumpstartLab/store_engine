require 'csv'

# to execute at command line
# rake import_stock[file path]

desc "Import seed product files"
task :import_stock, [:file] => :environment do |t,args|

    file = args[:file]
    CSV.foreach(file, :headers => true) do |row|
        Product.create({
        :title => row[0],
        :description => row[1],    
        :price => row[2],
        :remote_image_url => row[3],
        })
    end
end