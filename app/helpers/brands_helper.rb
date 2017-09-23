module BrandsHelper
  def options_for_brands
    Brand.official.map{|b|  [b.name, "Brand-#{b.id}"] }
  end
end
