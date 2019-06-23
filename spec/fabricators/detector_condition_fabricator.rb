Fabricator(:detector_condition) do
  detector    { Fabricate(:detector) }
  type        nil
  settings    { Hash.new }
end
