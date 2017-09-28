class Brand < ApplicationRecord
  belongs_to :app
  has_many :memberships, as: :member
  has_many :users, through: :memberships

  has_many :ownerships, as: :parent
  has_many :children, through: :ownerships, source: :child, source_type: 'Brand'
  has_many :standardizations, as: :referable
  has_many :standards, through: :standardizations

  validates_presence_of :name, :description, :app

  scope :official, -> { where(official: true) }

  def parent
    self.class.joins(:ownerships).where('ownerships.child_id = ? AND ownerships.child_type = ?', self.id, "Brand").first
  end
end