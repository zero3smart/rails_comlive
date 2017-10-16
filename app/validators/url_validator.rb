class UrlValidator < ActiveModel::EachValidator

  def validate_each(object, attribute, value)
    return unless value.present?

    unless value =~ /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
      object.errors[attribute] << 'is invalid'
    end
  end
end