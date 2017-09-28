class State < ApplicationRecord
  belongs_to :commodity

  ALLOWED_STATUSES = %w(warning stop recall)

  validates_presence_of :url,:status,:info, :commodity
  validates :status, inclusion: { in: ALLOWED_STATUSES, message: "%{value} is not a valid status" }
  validates_format_of :url, with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
end