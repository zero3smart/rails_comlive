class HscodeChapter < ApplicationRecord
  belongs_to :hscode_section
  has_many :hscode_headings

  validates_presence_of :category, :description, :hscode_section
  validates :category, length: { is: 2 }
  validates_uniqueness_of :category
end