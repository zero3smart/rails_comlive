class App < ApplicationRecord
  belongs_to :user
  has_many :commodities
  has_many :links
  has_many :references
  has_many :measurements
  has_many :custom_units
  has_many :brands
  has_many :standards
  has_many :members
  has_many :users, through: :members

  before_create :assign_uuid

  validates_presence_of :user, :name

  private

  def assign_uuid
    loop do
      self.uuid = SecureRandom.uuid
      break unless App.exists?(uuid: uuid)
    end
  end
end