class HscodeSection < ApplicationRecord
  has_many :hscode_chapters

  validates_presence_of :category, :description
  validates_uniqueness_of :category

  before_create :set_range

  private

  def set_range
    self.range = category.split('-').inject { |s,e| s.to_i..e.to_i }.to_a
  end
end
