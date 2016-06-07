require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MeasurementsHelper. For example:
#
# describe MeasurementsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MeasurementsHelper, :type => :helper do
  describe ".options_for_property" do
    app = FactoryGirl.create(:app)
    3.times { FactoryGirl.create(:custom_unit, app: app) }
    results = {
        'Custom Units' => app.custom_units.map(&:property),
        'Global Units' => Unitwise::Atom.all.uniq.map { |x| "#{x.property}" }.uniq
    }
    it "returns all grouped properties from unitwise and custom units" do
      expect(helper.options_for_property(app)).to eq results
    end
  end

  describe ".uoms_for_property" do
    context "given nil as input" do
      it "returns an empty array" do
        expect(helper.uoms_for_property(nil)).to match_array([])
      end
    end

    context "given property as input" do
      describe "when the property is a custom unit" do
        it "should include uoms from the database" do
          app = FactoryGirl.create(:app)
          custom_unit = FactoryGirl.create(:custom_unit, app: app)
          expected_results = ["#{custom_unit.property} (#{custom_unit.uom})", custom_unit.uom]
          expect(helper.uoms_for_property(custom_unit.property)).to match_array([expected_results])
        end
      end

      describe "when the property is a unitwise unit" do
        it "returns uoms for the given property from unitwise" do
          property =  Unitwise::Atom.all.uniq.map {|x| "#{x.property}"}.uniq.sample
          uoms =  Unitwise::Atom.all.select{|a| a.property == property }.map {|i| ["#{i.to_s(:names)} (#{i.to_s(:primary_code)})",i.to_s(:primary_code)] }

          expect(helper.uoms_for_property(property)).to match_array(uoms)
        end
      end
    end
  end
end
