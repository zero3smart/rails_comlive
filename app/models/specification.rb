class Specification < ApplicationRecord
  include Visibility

  belongs_to :parent, polymorphic: true

  validates_presence_of :property, :uom, :parent

  validates_presence_of :value, unless: lambda { self.max.present? || self.min.present? }
  validate :min_or_max_present, unless: lambda { self.value.present? }

  private

  def min_or_max_present
    if !min.present? && !max.present?
      errors[:base] << "You must set either a minimum or a maximum value"
    end
  end
end