require_relative './helper/spec_helper'

describe RoutificApi::Vehicle do
  describe "valid parameters" do
    subject(:vehicle) { Factory::VEHICLE }

    it "has id" do
      expect(vehicle.id).to eq(Factory::VEHICLE_ID)
    end

    it "has start_location" do
      expect(vehicle.start_location).to eq(RoutificApi::Location.new(Factory::VEHICLE_START_LOCATION))
    end

    it "has end_location" do
      expect(vehicle.end_location).to eq(RoutificApi::Location.new(Factory::VEHICLE_END_LOCATION))
    end

    it "has shift_start" do
      expect(vehicle.shift_start).to eq(Factory::VEHICLE_SHIFT_START)
    end

    it "has shift_end" do
      expect(vehicle.shift_end).to eq(Factory::VEHICLE_SHIFT_END)
    end

    it "has capacity" do
      expect(vehicle.capacity).to eq(Factory::VEHICLE_CAPACITY)
    end

    it "has strict_start" do
      expect(vehicle.strict_start).to eq(Factory::VEHICLE_STRICT_START)
    end

    it "has min_visits" do
      expect(vehicle.min_visits).to eq(Factory::VEHICLE_MIN_VISITS)
    end

    it "has speed" do
      expect(vehicle.speed).to eq(Factory::VEHICLE_SPEED)
    end

    it "has breaks" do
      expect(vehicle.breaks.kind_of?(Array)).to be(true)
      expect(vehicle.breaks[0]).to eq(RoutificApi::Break.new(Factory::BREAK_PARAMS))
    end

    describe "#as_json" do
      subject(:vehicleJSON) { vehicle.as_json }

      it "has start_location" do
        expect(vehicleJSON["start_location"]).to eq(Factory::VEHICLE_START_LOCATION)
      end

      it "has end_location" do
        expect(vehicleJSON["end_location"]).to eq(Factory::VEHICLE_END_LOCATION)
      end

      it "has shift_start" do
        expect(vehicleJSON["shift_start"]).to eq(Factory::VEHICLE_SHIFT_START)
      end

      it "has shift_end" do
        expect(vehicleJSON["shift_end"]).to eq(Factory::VEHICLE_SHIFT_END)
      end

      it "has capacity" do
        expect(vehicleJSON["capacity"]).to eq(Factory::VEHICLE_CAPACITY)
      end

      it "has strict_start" do
        expect(vehicleJSON["strict_start"]).to eq(Factory::VEHICLE_STRICT_START)
      end

      it "has min_visits" do
        expect(vehicleJSON["min_visits"]).to eq(Factory::VEHICLE_MIN_VISITS)
      end

      it "has speed" do
        expect(vehicleJSON["speed"]).to eq(Factory::VEHICLE_SPEED)
      end

      it "has breaks" do
        expect(vehicleJSON["breaks"]).to eq(Factory::VEHICLE_BREAKS)
      end
    end
  end

  describe "missing 'start_location' parameter" do
    subject(:vehicle) { RoutificApi::Vehicle.new(Factory::VEHICLE_ID, {
      "end_location"  => Factory::VEHICLE_END_LOCATION,
      "shift_start"   => Factory::VEHICLE_SHIFT_START,
      "shift_end"     => Factory::VEHICLE_SHIFT_END,
      "capacity"      => Factory::VEHICLE_CAPACITY
      }) }

    it "raises an ArgumentError" do
      expect { vehicle }.to raise_error(ArgumentError)
    end
  end

  describe "missing optional parameters" do
    subject(:vehicle) { RoutificApi::Vehicle.new(Factory::VEHICLE_ID, {
      "start_location"  => Factory::VEHICLE_START_LOCATION
      }) }

    it "does not raise any errors" do
      expect { vehicle }.to_not raise_error
    end

    describe "#as_json" do
      subject(:vehicleJSON) { vehicle.as_json }

      it "has start_location" do
        expect( vehicleJSON["start_location"] ).to eq(Factory::VEHICLE_START_LOCATION)
      end

      it "does not have end_location" do
        expect( vehicleJSON["end_location"] ).to be_nil
      end

      it "does not have shift_start" do
        expect( vehicleJSON["shift_start"] ).to be_nil
      end

      it "does not have shift_end" do
        expect( vehicleJSON["shift_end"] ).to be_nil
      end

      it "does not have capacity" do
        expect( vehicleJSON["capacity"] ).to be_nil
      end

      it "does not have strict_start" do
        expect( vehicleJSON["strict_start"] ).to be_nil
      end

      it "does not have min_visits" do
        expect( vehicleJSON["min_visits"] ).to be_nil
      end

      it "does not have speed" do
        expect( vehicleJSON["speed"] ).to be_nil
      end

      it "does not have breaks" do
        expect( vehicleJSON["breaks"] ).to be_nil
      end
    end
  end
end
