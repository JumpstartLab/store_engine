guard 'rspec', :version => 2 do
  watch(%r{^app/views/(.+)\.rb$}) { |m| "spec/views/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)\.rb$}) { |m| "spec/controllers/#{m[1]}_spec.rb" }
  watch(%r{^app/models/(.+)\.rb$}) { |m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^spec/views/(.+)_spec\.rb$})
  watch(%r{^spec/controllers/(.+)_spec\.rb$})
  watch(%r{^spec/models/(.+)_spec\.rb$})
  watch(%r{^spec/spec_helper.rb$})
end
