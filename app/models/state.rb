class State < ApplicationRecord
  belongs_to :commodity_reference

  ALLOWED_STATUSES = %w(warning stop recall)

  validates_presence_of :url,:status,:info, :commodity_reference
  validates :status, inclusion: { in: ALLOWED_STATUSES, message: "%{value} is not a valid status" }
  validates :url, url: true
end
