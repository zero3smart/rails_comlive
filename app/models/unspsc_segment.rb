class UnspscSegment < ApplicationRecord
  has_many :unspsc_families

  validates_presence_of :code, :long_code, :description
  validates :long_code, length: { is: 8 }

end
