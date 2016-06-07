class UnspscCommodity < ApplicationRecord
  belongs_to :unspsc_class

  validates_presence_of :code, :description, :unspsc_class, :long_code
  validates :long_code, length: { is: 8 }
end
