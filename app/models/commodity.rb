class Commodity < ApplicationRecord
  belongs_to :brand, optional: true
  has_many :commodity_references

  validates_presence_of :name, :measured_in
  validates_presence_of :brand_id, unless: "generic?"

  scope :generic, -> { where(generic: true )}
  scope :not_generic, -> { where(generic: false )}
  scope :recent, -> { order("created_at DESC") }

  searchkick word_start: [:name, :short_description, :long_description]

  # http://stackoverflow.com/questions/1680627/activerecord-findarray-of-ids-preserving-order
  scope :where_with_order, ->(ids) {
    order = sanitize_sql_array(
        ["position((',' || id::text || ',') in ?)", ids.join(',') + ',']
    )
    where(:id => ids).order(order)
  }

  before_create :set_uuid

  def as_json(options={})
    super(:only => [:id,:name]).merge(href:  Rails.application.routes.url_helpers.app_commodity_path(self.app,self))
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end