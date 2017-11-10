class Standard < ApplicationRecord
  include Uuideable

  has_many :memberships, foreign_key: :member_id, as: :member
  has_many :users, through: :memberships

  has_many :ownerships, as: :parent
  has_many :children, through: :ownerships, source: :child, source_type: 'Standard'

  has_many :standardizations
  has_many :brands, through: :standardizations, source: :referable, source_type: "Brand"
  has_many :commodity_references, through: :standardizations, source: :referable, source_type: "CommodityReference"

  validates_presence_of :name, :description

  scope :official, -> { where(official: true) }

  def parent
    self.class.joins(:ownerships).where('ownerships.child_id = ? AND ownerships.child_type = ?', self.id, "Standard").first
  end
end