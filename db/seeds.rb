
##################################################
# Accounts                                       #
##################################################

hilltop = Account.create(name: 'Hilltop Beverages')
brown = Account.create(name: 'Brown Canada Gas')

##################################################
# Progressions / Stages                          #
##################################################
# default_stages = [
#     { name: 'Prospect' },
#     { name: 'Lead' },
#     { name: 'Nurture' },
#     { name: 'Customer' },
#     { name: 'Bad Lead' }
# ]
# hilltop_funnel = Cornerkick::Progression.create(name: 'Entry Funnel', account: hilltop)
# default_stages.each do |stage|
#   Cornerkick::Stage.create(stage.merge(progression: hilltop_funnel))
# end
#
# hilltop_existing = Cornerkick::Progression.create(name: '2017 ReMarketing', account: hilltop)
# default_stages.each do |stage|
#   Cornerkick::Stage.create(stage.merge(progression: hilltop_existing))
# end
#
# brown_funnel = Cornerkick::Progression.create(name: 'Entry Funnel', account: brown)
# default_stages.each do |stage|
#   Cornerkick::Stage.create(stage.merge(progression: brown_funnel))
# end
#
# brown_existing = Cornerkick::Progression.create(name: '2017 ReMarketing', account: hilltop)
# default_stages.each do |stage|
#   Cornerkick::Stage.create(stage.merge(progression: brown_existing))
# end

##################################################
# Groups                                         #
##################################################

# A corps of giraffes
# A bloat of hippopotamuses
# A business of flies
# A crash of rhinoceroses
# A gaze of raccoons
# A parliament of owls
# A shrewdness of apes
# A scold of jays
# An obstinacy of buffalo
# A smack of jellyfish
# An ugly of walruses

rookery = Group.create(name: 'rookery', account: hilltop)
congregation = Group.create(name: 'congregation', account: hilltop)
troop = Group.create(name: 'troup', account: hilltop)
herd = Group.create(name: 'herd', account: hilltop)
plays_well = Group.create(name: 'plays-well-with-others', account: hilltop)

hilltop_groups = [rookery, congregation, troop, herd, plays_well]

actually = Group.create(name: 'actually', account: brown)
merge_conflict = Group.create(name: 'merge-conflict', account: brown)
embarrasment = Group.create(name: 'embarrasment', account: brown)
murder = Group.create(name: 'murder', account: brown)

##################################################
# Contacts                                       #
##################################################

anonymous1 = Contact.create(account: hilltop)
anonymous2 = Contact.create(account: hilltop)
anonymous3 = Contact.create(account: hilltop)
anonymous4 = Contact.create(account: hilltop)

anonymous5 = Contact.create(account: brown)
anonymous6 = Contact.create(account: brown)
anonymous7 = Contact.create(account: brown)
anonymous8 = Contact.create(account: brown)

##################################################
# Roles                                          #
##################################################

# site_admin = Cornerkick::Role.create(name: 'Site Admin')
account_admin = Role.create(name: Role::ACCOUNT_ADMIN)
team_admin = Role.create(name: Role::TEAM_ADMIN)
member = Role.create(name: Role::TEAM_MEMBER)

##################################################
# Users                                          #
##################################################

global_admin = User.create!(email: 'admin@example.com',
                                        first_name: 'Global',
                                        last_name: 'Admin',
                                        password: 'global',
                                        site_admin: true)

hilltop_admin = User.create!(email: 'admin@hilltop.com',
                                         first_name: 'Hilltop',
                                         last_name: 'Admin',
                                         password: 'hilltop')
RoleAssignment.create(account: hilltop, role: account_admin, user: hilltop_admin)

hilltop_member = User.create!(email: 'member@hilltop.com',
                                          first_name: 'Hilltop',
                                          last_name: 'Member',
                                          password: 'hilltop')
RoleAssignment.create(account: hilltop, role: member, user: hilltop_member)

brown_admin = User.create!(email: 'admin@brown.com',
                                       first_name: 'Brown',
                                       last_name: 'Admin',
                                       password: 'brownadmin')
RoleAssignment.create(account: brown, role: account_admin, user: brown_admin)

##################################################
# Trackers                                       #
##################################################

Tracker.create(identifier: 'CK-11111111', account: hilltop)

if Rails.env == 'development'
  require_relative '../spec/fabricators/account_fabricator'
  require_relative '../spec/fabricators/browser_fabricator'
  require_relative '../spec/fabricators/contact_fabricator'
  require_relative '../spec/fabricators/group_fabricator'
  require_relative '../spec/fabricators/grouping_fabricator'
  require_relative '../spec/fabricators/ip_address_fabricator'
  require_relative '../spec/fabricators/event_fabricator'

  # hilltop_prospect = Cornerkick::Stage.where(progression: hilltop_funnel, name: 'Prospect').first
  # hilltop_lead = Cornerkick::Stage.where(progression: hilltop_funnel, name: 'Lead').first

  Fabricate.times(200, :contact, account: hilltop, groups: hilltop_groups)
  Fabricate.times(200, :anonymous_contact, account: hilltop)
end

##################################################
# Campaigns                                      #
##################################################

northwest_distribution = Campaign.create(name: 'Northwest Distribution', active: true, account: hilltop)
CampaignSource.create(name: 'google', campaign: northwest_distribution)
CampaignTarget.create(landing_page: 'https://www.hilltop.com/im/a/landing-page', campaign: northwest_distribution)
CampaignAd.create(name: 'ready-go', campaign: northwest_distribution)
