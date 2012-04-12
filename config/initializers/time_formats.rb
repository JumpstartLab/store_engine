# config/initializers/time_formats.rb
Time::DATE_FORMATS[:month_day_and_year] = "%B %d, %Y"
Time::DATE_FORMATS[:pretty] = lambda { |time| time.strftime("%a, %b %e at %l:%M") + time.strftime("%p").downcase }