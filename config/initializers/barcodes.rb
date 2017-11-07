BARCODE_FORMATS = %w(bookland code_128 code_25 code_25_interleaved code_25_iata code_39 code_93 ean_13 ean_8 qr_code
                     upc_supplemental)

# the following are ommitted
# 1. pdf_417 -> Needs Jruby
# 2. data_matrix -> Can't figure out how to install semacode dependency
# 3. gs_128 -> Omitted in favour of code_128