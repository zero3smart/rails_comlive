class Brand < ApplicationRecord
  include Uuideable
  include Searchable

  has_many :memberships, as: :member
  has_many :users, through: :memberships
  has_many :commodities

  has_many :ownerships, as: :parent
  has_many :children, through: :ownerships, source: :child, source_type: 'Brand'
  has_many :standardizations, as: :referable
  has_many :standards, through: :standardizations

  searchkick

  validates_presence_of :name
  validates :url, :facebook_address, :open_corporate_url, :wipo_url, url: true, allow_blank: true
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, allow_blank: true

  scope :official, -> { where(official: true) }

  def parent
    self.class.joins(:ownerships).where('ownerships.child_id = ? AND ownerships.child_type = ?', self.id, "Brand").first
  end
end
