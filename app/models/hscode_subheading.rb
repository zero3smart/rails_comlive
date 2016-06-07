class HscodeSubheading < ApplicationRecord
  belongs_to :hscode_heading

  validates_presence_of :category, :description, :hscode_heading
  validates :category, uniqueness: true, length: { is: 6 }
end
