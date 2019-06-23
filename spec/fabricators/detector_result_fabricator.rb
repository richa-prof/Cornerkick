Fabricator(:detector_result) do
  detector          { Fabricate(:detector) }
  event             { Fabricate(:event) }
end
