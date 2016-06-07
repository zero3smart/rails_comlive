class UnspscFamily < ApplicationRecord
  belongs_to :unspsc_segment
  has_many :unspsc_classes

  validates_presence_of :code, :description, :unspsc_segment, :long_code
  validates :long_code, length: { is: 8 }
end
