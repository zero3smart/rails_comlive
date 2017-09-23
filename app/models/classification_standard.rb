class ClassificationStandard < ApplicationRecord
  belongs_to :level
  belongs_to :standard
  belongs_to :added_by, class_name: 'App'

  validates_presence_of :level, :standard, :added_by
end
