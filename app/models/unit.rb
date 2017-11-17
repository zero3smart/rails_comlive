class Unit < ApplicationRecord
  belongs_to :level
  belongs_to :added_by, class_name: 'App'

  validates_presence_of :added_by, :level, :uom
end