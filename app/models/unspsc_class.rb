class UnspscClass < ApplicationRecord
  belongs_to :unspsc_family
  has_many :unspsc_commodities

  validates_presence_of :code, :description, :unspsc_family, :long_code
  validates :long_code, length: { is: 8 }
end
