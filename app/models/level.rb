class Level < ApplicationRecord
  belongs_to :classification
  belongs_to :added_by, class_name: 'App'
  belongs_to :parent, class_name: 'Level'
  has_many :children, class_name: 'Level', foreign_key: 'parent_id'
  has_many :classification_standards
  has_many :classification_commodities
  has_many :units

  validates_presence_of :classification, :added_by, :name, :position

  scope :root, -> { where("parent_id IS ?", nil) }
end