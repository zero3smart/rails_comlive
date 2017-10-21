require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SpecificationsHelper. For example:
#
# describe SpecificationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SpecificationsHelper, :type => :helper do
  describe ".object_url" do
    include ActionDispatch::Routing::PolymorphicRoutes
    include Rails.application.routes.url_helpers

    before(:each) do
      @comm_ref = create(:commodity_reference)
      @specification = Specification.new
    end

    context "Given a commodity" do
      it "returns path for commodity specification" do
        expect(polymorphic_path(helper.object_url(@comm_ref))).to eq polymorphic_path([@comm_ref.app,@comm_ref,@specification])
        expect(new_polymorphic_path(helper.object_url(@comm_ref))).to eq new_polymorphic_path([@comm_ref.app,@comm_ref,@specification])
      end
    end

    context "Given a packaging" do
      it "returns path  for packaging specification" do
        @packaging = create(:packaging, commodity_reference_id: @comm_ref.id)
        expect(polymorphic_path(helper.object_url(@packaging))).to eq polymorphic_path([@comm_ref.app,@comm_ref,@packaging, @specification])
        expect(new_polymorphic_path(helper.object_url(@packaging))).to eq new_polymorphic_path([@comm_ref.app,@comm_ref,@packaging, @specification])
      end
    end
  end

  describe '.is_checked?' do
    context "Given type value and a new specification" do
      it "returns true" do
        specification = Specification.new
        expect(helper.is_checked?(specification, "value")).to eq true
      end
    end

    context "Given type value and a specification with a value" do
      it "returns true" do
        specification = create(:specification)
        expect(helper.is_checked?(specification,"value")).to eq true
      end
    end

    context "Given type min-max with min or max present" do
      it "returns true" do
        specification = create(:spec_with_min_max)
        expect(helper.is_checked?(specification, "min-max")).to eq true
      end
    end
  end

  describe ".unitwise_atoms" do
    it "returns atoms from unitwise gem" do
      atoms = Unitwise::Atom.all.uniq.map { |x| "#{x.property}" }.uniq.map{|a|
        [a, a.titleize.split(' ').join.underscore]
      }
      expect(helper.unitwise_atoms).to eq atoms
    end
  end

  describe ".options_for_property" do
    app = FactoryGirl.create(:app)
    FactoryGirl.create_list(:custom_unit, 3, app: app)
    atoms = Unitwise::Atom.all.uniq.map { |x| "#{x.property}" }.uniq.map{|a|
      [a, a.titleize.split(' ').join.underscore]
    }
    results = {
        'Custom Units' => app.custom_units.map(&:property),
        'Global Units' => atoms
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

def atoms
  Unitwise::Atom.all.uniq.map { |x| "#{x.property}" }.uniq.map{|a|
    [a, a.titleize.split(' ').join.underscore]
  }
end