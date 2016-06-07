class GenericValidator < ActiveModel::EachValidator

  def validate_each(object, attribute, value)
    return unless value.present?

    unless value.generic
      object.errors[attribute] << "is not generic"
    end
  end
end
