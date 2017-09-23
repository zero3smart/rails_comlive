class App < ApplicationRecord
  has_many :commodity_references
  has_many :links
  has_many :references
  has_many :measurements
  has_many :custom_units
  has_many :standards
  has_many :invitations
  has_many :memberships, as: :member
  has_many :users, through: :memberships
  has_many :classifications
  has_many :ownerships, as: :parent
  has_many :brands, through: :ownerships, source: :child, source_type: 'Brand'

  before_create :assign_uuid

  validates_presence_of :name

  def owner
    memberships.find_by(owner: true).user
  end

  private

  def assign_uuid
    loop do
      self.uuid = SecureRandom.uuid
      break unless App.exists?(uuid: uuid)
    end
  end
end
