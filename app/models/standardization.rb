class Standardization < ApplicationRecord
  belongs_to :standard
  belongs_to :user
  belongs_to :referable, polymorphic: true

  validates_uniqueness_of :standard_id, scope: [:referable_type,:referable_id]
  validates_presence_of :referable, :user, :standard
end
