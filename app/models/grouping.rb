class Grouping < ApplicationRecord
  belongs_to :group, touch: true
  belongs_to :contact, touch: true
end
