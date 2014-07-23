require_relative './helper/spec_helper'

describe Location do
  describe "valid parameters" do
    subject(:location) { Factory::LOCATION }

    it "has name" do
      expect(location.name).to eq(Factory::LOCATION_NAME)
    end

    it "has latitude" do
      expect(location.lat).to eq(Factory::LOCATION_LATITUDE)
    end

    it "has longitude" do
      expect(location.lng).to eq(Factory::LOCATION_LONGITUDE)
    end

    describe "#to_json" do
      subject(:locationJSON) { JSON.parse(location.to_json(nil)) }

      it "can be reconverted to JSON" do
        expect { locationJSON }.to_not raise_error
      end

      it "has name" do
        expect(locationJSON["name"]).to eq(Factory::LOCATION_NAME)
      end

      it "has lat" do
        expect(locationJSON["lat"]).to eq(Factory::LOCATION_LATITUDE)
      end

      it "has lng" do
        expect(locationJSON["lng"]).to eq(Factory::LOCATION_LONGITUDE)
      end
    end
  end

  describe "missing 'lat' parameter" do
    subject(:location) { Location.new({
      "name" => Factory::LOCATION_NAME,
      "lng" => Factory::LOCATION_LONGITUDE
      }) }

    it "raises ArgumentError" do
      expect { location }.to raise_error(ArgumentError)
    end
  end

  describe "missing 'lng' parameter" do
    subject(:location) { Location.new({
      "name" => Factory::LOCATION_NAME,
      "lat" => Factory::LOCATION_LATITUDE
      }) }

    it "raises ArgumentError" do
      expect { location }.to raise_error(ArgumentError)
    end
  end

  describe "missing 'name' parameter" do
    subject(:location) { Location.new({
      "lat" => Factory::LOCATION_LATITUDE,
      "lng" => Factory::LOCATION_LONGITUDE
      }) }

    it "does not raise any errors" do
      expect { location }.to_not raise_error
    end

    describe "#to_json" do
      subject(:locationJSON) { JSON.parse(location.to_json) }

      it "does not have name" do
        expect(locationJSON["name"]).to be_nil
      end
    end
  end
end