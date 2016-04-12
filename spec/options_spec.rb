require_relative './helper/spec_helper'

describe RoutificApi::Options do
  describe "valid parameters" do
    subject(:options) { Factory::ROUTE_OPTIONS }

    it "has traffic" do
      expect(options.traffic).to eq(Factory::ROUTE_OPTIONS_TRAFFIC)
    end

    it "has min_visits_per_vehicle" do
      expect(options.min_visits_per_vehicle).to eq(Factory::ROUTE_OPTIONS_MIN_VISITS_PER_VEHICLE)
    end

    it "has balance" do
      expect(options.balance).to eq(Factory::ROUTE_OPTIONS_BALANCE)
    end

    it "has min_vehicles" do
      expect(options.min_vehicles).to eq(Factory::ROUTE_OPTIONS_MIN_VEHICLES)
    end

    it "has shortest_distance" do
      expect(options.shortest_distance).to eq(Factory::ROUTE_OPTIONS_SHORTEST_DISTANCE)
    end

    describe "#as_json" do
      subject(:optionsJSON) { options.as_json }

      it "has traffic" do
        expect(optionsJSON["traffic"]).to eq(Factory::ROUTE_OPTIONS_TRAFFIC)
      end

      it "has min_visits_per_vehicle" do
        expect(optionsJSON["min_visits_per_vehicle"]).to eq(Factory::ROUTE_OPTIONS_MIN_VISITS_PER_VEHICLE)
      end

      it "has balance" do
        expect(optionsJSON["balance"]).to eq(Factory::ROUTE_OPTIONS_BALANCE)
      end

      it "has min_vehicles" do
        expect(optionsJSON["min_vehicles"]).to eq(Factory::ROUTE_OPTIONS_MIN_VEHICLES)
      end

      it "has shortest_distance" do
        expect(optionsJSON["shortest_distance"]).to eq(Factory::ROUTE_OPTIONS_SHORTEST_DISTANCE)
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
