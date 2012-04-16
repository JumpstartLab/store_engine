Fabricator(:status, :class_name => "Status") do
  id { sequence }
  name { StoreEngine::Status::PENDING }
end
