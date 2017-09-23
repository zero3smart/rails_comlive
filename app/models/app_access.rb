class AppAccess < ApplicationRecord
  belongs_to :app
  belongs_to :classification
  belongs_to :added_by, class_name: 'App'

  validates_presence_of :app, :added_by, :classification
end
