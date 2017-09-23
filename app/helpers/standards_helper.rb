module StandardsHelper
  def options_for_standards
    Standard.where(official: true).find_each.map {|s| [s.name, "Standard-#{s.id}"] }
  end
end
