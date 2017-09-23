module BarcodesHelper
  def options_for_barcodes
    BARCODE_FORMATS.map {|bc| [bc.titleize.upcase, bc]}
  end
end
