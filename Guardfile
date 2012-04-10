# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', :version => 2 do
  watch(%r{^app/controllers/(.+)\.rb$}) {|m| "spec/controllers/#{m[1]}_spec.rb" }
  watch(%r{^app/models/(.+)\.rb$}) {|m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^app/**/(.+)\.rb$}) {|m| "spec/controllers/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^spec/**/(.+)_spec\.rb})
end
