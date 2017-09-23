module ReferencesHelper
  def options_for_kind
    %w(specific_of variation_of alternative_to).map{|k| [k.titleize, k]}
  end

  def options_for_references(reference)
    return [] if reference.new_record?
    [[reference.source_commodity.name, reference.source_commodity.id]]
  end
end
