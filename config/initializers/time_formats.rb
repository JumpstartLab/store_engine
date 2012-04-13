# config/initializers/time_formats.rb
Time::DATE_FORMATS[:month_day_and_year] = "%B %d, %Y"
Time::DATE_FORMATS[:pretty] = lambda do |time| 
  formatted_time = time.in_time_zone("Eastern Time (US & Canada)")
  formatted_time = formatted_time.strftime("%a, %B %d, %Y at %l:%M")
  formatted_time = formatted_time.strftime("%p").downcase
end