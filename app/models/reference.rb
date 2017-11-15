class Reference < ApplicationRecord
  include Visibility

  belongs_to :app
  belongs_to :commodity_reference
  belongs_to :source_commodity, class_name: "Commodity"
  belongs_to :target_commodity, class_name: "Commodity"

  validates_presence_of :app, :commodity_reference,:source_commodity,:target_commodity,:description, :kind
  validates_inclusion_of :kind, in: %w(specific_of variation_of alternative_to), message: "is not allowed"
  validates :source_commodity, generic: true
end