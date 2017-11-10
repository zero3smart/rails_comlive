class Commodity < ApplicationRecord
  include Uuideable

  belongs_to :brand, optional: true
  has_many :commodity_references
  has_many :barcodes, as: :barcodeable

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

  def create_reference(user)
    app = user.default_app
    attributes = self.class.attribute_names.reject{|a|
      ["id","created_at","updated_at","uuid"].include?(a)
    }
    attributes = attributes.each_with_object({}) do |attribute,hash|
      hash[attribute] = self.send(attribute)
    end
    self.commodity_references.create!(attributes.merge(app_id: app.id))
  end

  def as_json(options={})
    super(:only => [:id,:name]).merge(href:  Rails.application.routes.url_helpers.slugged_commodity_path(self.uuid,self.name.parameterize))
  end
end