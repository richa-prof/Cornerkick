Fabricator(:grouping) do
  group     { Fabricate(:group) }
  contact   { Fabricate(:contact) }
end
