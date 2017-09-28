class Packaging < ApplicationRecord
  belongs_to :commodity

  validates_presence_of :uom, :quantity, :name, :description, :commodity

  before_create :set_uuid

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end