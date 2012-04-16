Fabricator(:status, :aliases => [:statu], :class_name => "Status") do
  id { sequence(:number, 100) }
  name { StoreEngine::Status::PENDING }
end
