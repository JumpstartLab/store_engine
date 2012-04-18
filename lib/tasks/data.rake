require 'csv'

namespace :data do
  task :load => :environment do
    file_name = "data.csv"
    puts "Loading Data"

    csv = CSV.open("db/#{file_name}", {:headers => true, :header_converters => :symbol})
    csv.each do |line|
      Product.create(
        :name => line[:title],
        :description => line[:description],
        :price => line[:price],
        :avatar_from_url => line[:photo_url]
      )
    end


    puts "Data Loaded!"
  end
end