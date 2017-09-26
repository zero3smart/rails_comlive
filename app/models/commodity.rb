class Commodity < ApplicationRecord
  belongs_to :app
  belongs_to :brand, optional: true
  belongs_to :hscode_section, optional: true
  belongs_to :hscode_chapter, optional: true
  belongs_to :hscode_heading, optional: true
  belongs_to :hscode_subheading, optional: true
  belongs_to :unspsc_class, optional: true
  belongs_to :unspsc_commodity, optional: true
  belongs_to :unspsc_family, optional: true
  belongs_to :unspsc_segment, optional: true

  has_many :links
  has_many :references
  has_many :packagings
  has_many :standardizations, as: :referable
  has_many :standards, through: :standardizations
  has_many :measurements
  has_one :state

  validates_presence_of :app, :short_description, :long_description, :measured_in
  validates_presence_of :brand_id, unless: "generic?"

  scope :generic, -> { where(generic: true )}
  scope :not_generic, -> { where(generic: false )}

  before_save :set_unspsc_fields
  before_create :set_uuid


  def self.search(term, generic)
    return self.generic.where("short_description iLIKE ?", "%#{term}%") if generic
    self.not_generic.where("short_description iLIKE ?", "%#{term}%")
  end

  def as_json(options={})
    super(:only => [:id,:short_description])
  end


  private

  def set_unspsc_fields
    return unless self.unspsc_commodity_id
    unspsc_commodity = UnspscCommodity.find(unspsc_commodity_id)
    unspsc_class = unspsc_commodity.unspsc_class
    unspsc_family = unspsc_class.unspsc_family
    unspsc_segment = unspsc_family.unspsc_segment
    self.unspsc_commodity, self.unspsc_class, self.unspsc_family, self.unspsc_segment = [
        unspsc_commodity, unspsc_class, unspsc_family, unspsc_segment
    ]
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end