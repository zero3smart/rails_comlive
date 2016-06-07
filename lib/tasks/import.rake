namespace :db do
  namespace :import do
    desc "Imports and creates unspsc codes"
    task :unspsc_codes => :environment do
      start_time = Time.now

      puts "=> Reading unspsc excel file."
      spreadsheet = Roo::Excelx.new("data/unspsc.xlsx")
      headers = ["segment", "segment_title", "family", "family_title", "class_code", "class_title", "key_code",
                 "commodity", "commodity_title", "definition", "synonym"]

      puts "=> Importing unspc codes. This may take a while. Be patient..."
      (11..spreadsheet.last_row).each do |num|
        record = Hash[headers.zip(spreadsheet.row(num))]
        unless record["commodity"].nil?
          seg_code = record["segment"].to_s.scan(/../)[0]
          seg = { code: seg_code ,
                  description:  record["segment_title"], long_code: seg_code.ljust(8,"0") }
          fam_code = record["family"].to_s.scan(/../)[1]
          fam = { code: fam_code, description:  record["family_title"],
                  long_code: "#{seg_code}#{fam_code}".ljust(8,"0") }
          cls_code = record["class_code"].to_s.scan(/../)[2]
          cls = { code: cls_code, description:  record["class_title"],
                  long_code: "#{seg_code}#{fam_code}#{cls_code}".ljust(8,"0") }
          cmm_code = record["commodity"].to_s.scan(/../)[3]
          cmm = { code: cmm_code, description:  record["commodity_title"],
                  long_code: "#{seg_code}#{fam_code}#{cls_code}#{cmm_code}" }

          usegment = UnspscSegment.where(code: seg[:code]).first_or_create!(seg.except(:code))
          ufamily = usegment.unspsc_families.where(code: fam[:code]).first_or_create!(fam.except(:code))
          uclass = ufamily.unspsc_classes.where(code: cls[:code]).first_or_create!(cls.except(:code))
          ucomm = uclass.unspsc_commodities.where(code: cmm[:code]).first_or_create!(cmm.except(:code))

          puts "  * Saved commodity: #{ucomm.description}"
        end
      end
      puts "\n======= Done (#{((Time.now - start_time)/60).round(2)} min) =========\n"
    end

    desc "Imports and creates hscodes"
    task :hscodes => :environment do
      puts "=> Creating manual sections"
      sections = [
          { category: '01-05', description: 'Animal & Animal Products' },
          { category: '06-15', description: 'Vegetable Products'},
          { category: '16-24', description: 'Foodstuffs' },
          { category: '25-27', description: 'Mineral Products'},
          { category: '28-38', description: 'Chemicals & Allied Industries'},
          { category: '39-40', description: 'Plastics / Rubbers'},
          { category: '41-43', description: 'Raw Hides, Skins, Leather, & Furs'},
          { category: '44-49', description: 'Wood & Wood Products'},
          { category: '50-63', description: 'Textiles'},
          { category: '64-67', description: 'Footwear / Headgear'},
          { category: '68-71', description: 'Stone / Glass'},
          { category: '72-83', description: 'Metals'},
          { category: '84-85', description: 'Machinery / Electrical'},
          { category: '86-89', description: 'Transportation'},
          { category: '90-97', description: 'Miscellaneous'},
          { category: '98-99', description: 'Service'}
      ]
      HscodeSection.create!(sections)
      puts "   * Created #{HscodeSection.count} sections"

      puts "=> Importing chapters, headings and subheadings from API."

      uri = URI('http://comtrade.un.org/data/cache/classificationH4.json')
      response = JSON.parse Net::HTTP.get(uri)

      response["results"].reject{|r| r["parent"] == "#" }.each_with_index do |result, index|
        category    = result["id"]
        description = result["text"].gsub(/^[0-9]+/,'').gsub(/\s-/,'').gsub(/^-|\:/,'').strip
        parent      = result["parent"]

        case category.length
          when 2
            hscode_section = HscodeSection.where("'#{category.to_i}' = ANY (range)").first
            hscode_section.hscode_chapters.create!(category: category, description: description)
          when 4
            hscode_chapter = HscodeChapter.find_by(category: parent)
            hscode_chapter.hscode_headings.create!(category: category, description: description)
          when 6
            hscode_heading = HscodeHeading.find_by(category: parent) # TODO: fix bug
            hscode_heading.hscode_subheadings.create!(category: category, description: description)
        end
        print "   *" if index % 1000 == 0
      end
      puts "=> Done!"
    end
  end
end