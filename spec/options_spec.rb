require_relative './helper/spec_helper'

describe RoutificApi::Options do
  describe "valid parameters" do
    subject(:options) { Factory::ROUTE_OPTIONS }
    
    Factory::ROUTE_OPTIONS_PARAMS.each do |key, value|
      it "has #{key}" do
        expect(eval("options.#{key}")).to eq(value)
      end
    end
    
    describe "#as_json" do
      subject(:optionsJSON) { options.as_json }

      Factory::ROUTE_OPTIONS_PARAMS.each do |key, value|
        it "has #{key}" do
          expect(optionsJSON[key]).to eq(value)
        end
      end
    end
  end

  describe "provided invalid parameters" do
    subject(:options) { RoutificApi::Options.new({
      "bad_parameter" => "bad_parameter"
      }) }

    it "raises an ArgumentError" do
      expect { options }.to raise_error(ArgumentError)
    end
  end
end
