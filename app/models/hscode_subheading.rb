class HscodeSubheading < ApplicationRecord
  belongs_to :hscode_heading

  validates_presence_of :category, :description, :hscode_heading
  validates :category, length: { is: 6 }
  validates_uniqueness_of :category
end
