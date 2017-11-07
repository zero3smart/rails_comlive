class BarcodeValidator < ActiveModel::Validator

  def validate(record)
    return unless record.format.present?

    # if the generator is unable to create a barcode with the supplied format and content then
    # we deem the record invalid
    begin
      BarcodeGenerator.new(record.format, record.content)
      BarcodeGenerator.new(record.format, record.content).generate
    rescue Exception => e
      message = e.message.match(/undefined method/) ? "Invalid data" : e.message
      record.errors[:content] << "is invalid for format '#{record.format.upcase}'. Reason: #{message}"
    end
  end
end