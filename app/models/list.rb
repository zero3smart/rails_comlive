class List < ApplicationRecord
  belongs_to :user

  validates_presence_of :user

  after_save :ensure_maximum_count

  private

  def ensure_maximum_count
    if commodities.length > 10
      current_ids = commodities
      current_ids.shift
      update(commodities: current_ids)
    end
  end
end
