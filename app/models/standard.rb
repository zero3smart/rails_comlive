class Standard < ApplicationRecord
  include Uuideable
  include Visibility
  include Searchable

  belongs_to :brand

  has_many :memberships, foreign_key: :member_id, as: :member
  has_many :users, through: :memberships

  has_many :ownerships, as: :parent
  has_many :children, through: :ownerships, source: :child, source_type: 'Standard'

  has_many :standardizations
  has_many :brands, through: :standardizations, source: :referable, source_type: "Brand"
  has_many :commodity_references, through: :standardizations, source: :referable, source_type: "CommodityReference"
  has_many :commodities, through: :commodity_references

  validates_presence_of :name, :code, :version, :description, :brand_id
  validates :certifier_url, url: true, allow_blank: true

  searchkick word_start: [:name, :description]

  def parent
    self.class.joins(:ownerships).where('ownerships.child_id = ? AND ownerships.child_type = ?', self.id, "Standard").first
  end
end
