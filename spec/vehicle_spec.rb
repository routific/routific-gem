require_relative './helper/spec_helper'

describe Vehicle do
  describe "valid parameters" do
    subject(:vehicle) { Factory::VEHICLE }

    it "has start_location" do
      expect(vehicle.start_location).to eq(Factory::VEHICLE_START_LOCATION)
    end

    it "has end_location" do
      expect(vehicle.end_location).to eq(Factory::VEHICLE_END_LOCATION)
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

    describe "#as_json" do
      subject(:vehicleJSON) { vehicle.as_json }

      it "has start_location" do
        expect(vehicleJSON["start-location"]).to eq(Factory::VEHICLE_START_LOCATION)
      end

      it "has end_location" do
        expect(vehicleJSON["end-location"]).to eq(Factory::VEHICLE_END_LOCATION)
      end

      it "has shift_start" do
        expect(vehicleJSON["shift-start"]).to eq(Factory::VEHICLE_SHIFT_START)
      end

      it "has shift_end" do
        expect(vehicleJSON["shift-end"]).to eq(Factory::VEHICLE_SHIFT_END)
      end

      it "has capacity" do
        expect(vehicleJSON["capacity"]).to eq(Factory::VEHICLE_CAPACITY)
      end
    end
  end

  describe "missing 'start_location' parameter" do
    subject(:vehicle) { Vehicle.new({
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
    subject(:vehicle) { Vehicle.new({
      "start_location"  => Factory::VEHICLE_START_LOCATION
      }) }

    it "does not raise any errors" do
      expect { vehicle }.to_not raise_error
    end

    describe "#as_json" do
      subject(:vehicleJSON) { vehicle.as_json }

      it "has start_location" do
        expect( vehicleJSON["start-location"] ).to eq(Factory::VEHICLE_START_LOCATION)
      end

      it "does not have end_location" do
        expect( vehicleJSON["end-location"] ).to be_nil
      end

      it "does not have shift_start" do
        expect( vehicleJSON["shift-start"] ).to be_nil
      end

      it "does not have shift_end" do
        expect( vehicleJSON["shift-end"] ).to be_nil
      end

      it "does not have capacity" do
        expect( vehicleJSON["capacity"] ).to be_nil
      end
    end
  end
end
