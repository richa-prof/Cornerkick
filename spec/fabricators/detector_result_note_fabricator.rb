Fabricator(:detector_result_note) do
  detector_result   { Fabricate(:detector_result) }
  content           { Faker::StarWars.quote }
  scribe            nil
end
