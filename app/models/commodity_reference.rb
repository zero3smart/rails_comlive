class CommodityReference < ApplicationRecord
  include Searchable

  belongs_to :app
  belongs_to :commodity
  belongs_to :brand, optional: true
  belongs_to :hscode_section, optional: true
  belongs_to :hscode_chapter, optional: true
  belongs_to :hscode_heading, optional: true
  belongs_to :hscode_subheading, optional: true
  belongs_to :unspsc_class, optional: true
  belongs_to :unspsc_commodity, optional: true
  belongs_to :unspsc_family, optional: true
  belongs_to :unspsc_segment, optional: true

  has_many :links, dependent: :destroy
  has_many :references, dependent: :destroy
  has_many :packagings, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :standardizations, as: :referable, dependent: :destroy
  has_many :standards, through: :standardizations, dependent: :destroy
  has_many :specifications, as: :parent, dependent: :destroy
  has_one :state

  validates_presence_of :app, :commodity, :measured_in
  validates_presence_of :brand_id, unless: "generic?"

  before_create :set_uuid
  before_save :set_unspsc_fields

  scope :generic, -> { where(generic: true )}
  scope :not_generic, -> { where(generic: false )}
  scope :recent, -> { order("created_at DESC") }

  # http://stackoverflow.com/questions/1680627/activerecord-findarray-of-ids-preserving-order
  scope :where_with_order, ->(ids) {
    order = sanitize_sql_array(
        ["position((',' || id::text || ',') in ?)", ids.join(',') + ',']
    )
    where(:id => ids).order(order)
  }

  def as_json(options={})
    super(:only => [:id,:name]).merge(href:  Rails.application.routes.url_helpers.app_commodity_reference_path(self.app,self))
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

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
