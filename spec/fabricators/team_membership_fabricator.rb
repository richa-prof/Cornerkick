Fabricator(:team_membership) do
  user { Fabricate(:user) }
  team { Fabricate(:team) }
end
