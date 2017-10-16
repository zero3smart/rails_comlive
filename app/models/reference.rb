class Reference < ApplicationRecord
  belongs_to :app
  belongs_to :source_commodity_reference, class_name: "CommodityReference"
  belongs_to :target_commodity_reference, class_name: "CommodityReference"

  validates_presence_of :app,:source_commodity_reference,:target_commodity_reference,:description, :kind
  validates_inclusion_of :kind, in: %w(specific_of variation_of alternative_to), message: "is not allowed"
  validates :source_commodity_reference, generic: true
end