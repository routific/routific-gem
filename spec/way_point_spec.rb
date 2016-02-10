require_relative './helper/spec_helper'

describe RoutificApi::Vehicle do
  describe "valid parameters" do
    subject(:way_point) { Factory::WAY_POINT }

    it "has location_id" do
      expect(way_point.location_id).to eq(Factory::WAY_POINT_LOCATION_ID)
    end

    it "has arrival_time" do
      expect(way_point.arrival_time).to eq(Factory::WAY_POINT_ARRIVAL_TIME)
    end

    it "has finish_time" do
      expect(way_point.finish_time).to eq(Factory::WAY_POINT_FINISH_TIME)
    end

    it "has a location name" do
      expect(way_point.location_name).to eq(Factory::WAY_POINT_LOCATION_NAME)
    end
  end
end
