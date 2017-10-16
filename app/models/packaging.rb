class Packaging < ApplicationRecord
  belongs_to :commodity_reference
  has_many :specifications, as: :parent

  validates_presence_of :uom, :quantity, :name, :description, :commodity_reference

  before_create :set_uuid

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end