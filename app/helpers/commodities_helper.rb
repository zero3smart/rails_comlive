module CommoditiesHelper
  def options_for_hscode_sections
    HscodeSection.all.map{|hs| [hs.description, hs.id]}
  end

  def recent_commodities
    return [] if cookies[:recent_commodities].nil?
    commodity_ids =  cookies[:recent_commodities].split(",")
    Commodity.where_with_order(commodity_ids)
  end
end