class ClassificationCommodity < ApplicationRecord
  belongs_to :level
  belongs_to :commodity
  belongs_to :added_by, class_name: 'App'

  validates_presence_of :level, :commodity, :added_by
end