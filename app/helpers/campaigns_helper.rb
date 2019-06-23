module CampaignsHelper
  def url_group_display_name(url)
    display = 'unassigned'
    display = url.group.name if url.group
    display
  end
end
