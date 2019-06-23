class Contact < ApplicationRecord
  belongs_to :account
  # belongs_to :stage, optional: true

  has_many :groupings
  has_many :groups, through: :groupings

  has_many :browsers
  has_many :events

  def full_name
    "#{first_name} #{last_name}"
  end

  def display_name
    display = full_name
    if display.blank?
      event = events.last
      ip = event.ip_address unless event.nil?
      display = ip.ip_address unless ip.nil?
    end
    display = 'Anonymous' if display.blank?
    display
  end

  def visit_count
    events.where(event_type: 'visit').count
  end

  def click_count
    events.where(event_type: 'click').count
  end

  def first_seen
    visit = events.order(created_at: :asc).first
    date = ''
    date = visit.created_at.strftime('%B %d %Y') if visit
    date
  end

  def last_seen
    visit = events.order(created_at: :asc).last
    date = ''
    date = visit.created_at.strftime('%B %d %Y') if visit
    date
  end

  def group?(group)
    groupings.any? { |g| g.group_id == group.id }
  end

  def group_names
    groups.collect(&:name)
  end

  def group_names=(names)
    names.each do |name|
      group = Group.find_by(name: name)
      add_group group unless group.nil? && group?(group)
    end
    delete_groups = group_names - names
    delete_groups.each do |name|
      group = Group.find_by(name: name)
      remove_group group
    end
  end

  def add_group(group)
    groupings << Grouping.new(contact: self, group: group) unless group? group
  end

  def remove_group(group)
    return unless group? group

    groups.each do |g|
      groups.delete g if g.id == group.id
    end
  end
end
