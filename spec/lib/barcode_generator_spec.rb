require 'barby'
require 'barby/barcode/bookland'
require 'barby/barcode/code_128'
require 'barby/barcode/code_25'
require 'barby/barcode/code_25_interleaved'
require 'barby/barcode/code_25_iata'
require 'barby/barcode/code_39'
require 'barby/barcode/code_93'
require 'barby/barcode/ean_13'
require 'barby/barcode/ean_8'
require 'barby/barcode/qr_code'
require 'barby/barcode/upc_supplemental'
# require 'barby/barcode/pdf_417'
# require 'barby/barcode/data_matrix' => unable to install dependency semacode
# require 'barby/barcode/gs1_128' => looks like its dropped in favour of code 128


require 'barby/outputter/html_outputter'
require 'barby/outputter/png_outputter'

class BarcodeGenerator
  attr_reader :barcode, :format

  def initialize(format, content)
    @format = format
    klass = normalize_class(format)
    @barcode = format == "qr_code" ? klass.new(content, level: :q, size: 5) : klass.new(content)
  end

  def generate
    return barcode.to_html unless format.eql?("qr_code")
    base64_output = Base64.encode64(barcode.to_png({ xdim: 5 }))
    "data:image/png;base64,#{base64_output}"
  end

  private

  def normalize_class(type)
    case type
      when  "ean_13"
        Barby::EAN13
      when "ean_8"
        Barby::EAN8
      when "upc_supplemental"
        Barby::UPCSupplemental
      when "code_25_iata"
        Barby::Code25IATA
      else
        "Barby/#{type}".classify.constantize
    end
  end
end