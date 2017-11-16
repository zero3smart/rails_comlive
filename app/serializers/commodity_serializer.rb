class CommoditySerializer < ActiveModel::Serializer
  attributes :id, :name, :short_description

  link(:self) { api_v1_commodity_path(object) }
end