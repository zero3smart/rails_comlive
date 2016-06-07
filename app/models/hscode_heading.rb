class HscodeHeading < ApplicationRecord
  belongs_to :hscode_chapter
  has_many :hscode_subheadings

  validates_presence_of :category, :description
  validates :category, uniqueness: true, length: { is: 4 }
end
