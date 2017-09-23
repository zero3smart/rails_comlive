module CommoditiesHelper
  def options_for_hscode_sections
    HscodeSection.all.map{|hs| [hs.description, hs.id]}
  end

  def recent_commodities
    return [] if cookies[:recent_commodities].nil?
    commodity_ids =  cookies[:recent_commodities].split(",")
    Commodity.where_with_order(commodity_ids)
  end

  def barcode_for(model)
    if model.is_a? Commodity
      url = slugged_commodity_url(model.uuid,model.name.parameterize, locale: I18n.locale)
    elsif model.is_a? Packaging
      url = slugged_packaging_url(model.uuid,model.name.parameterize, locale: I18n.locale)
    end
    png_string = BarcodeGenerator.new("qr_code", url).generate
    image_tag png_string, class: "qr_code"
  end

  def options_for_measures
    %w(number mass length volume time).map{|m| [m.titleize,m, data: { subtext: "Description" }]}
  end
end
