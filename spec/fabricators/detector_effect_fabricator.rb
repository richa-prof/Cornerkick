Fabricator(:detector_effect) do
  detector    { Fabricator(:detector) }
  type        nil
  settings    { Hash.new }
end
