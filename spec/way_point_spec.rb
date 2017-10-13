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

    it "has idle_time" do
      expect(way_point.idle_time).to eq(Factory::WAY_POINT_IDLE_TIME)
    end
  end

  describe "break" do
    subject(:way_point_break) { Factory::WAY_POINT_BREAK }

    Factory::WAY_POINT_BREAK_PARAMS.each do |key, value|
      it "has #{key}" do
        expect(eval("way_point_break.#{key}")).to eq(value)
      end
    end
  end

  describe "lateness" do
    subject(:way_point_late) { Factory::WAY_POINT_LATE }

    it "has too_late" do
      expect(way_point_late.too_late).to eq(Factory::WAY_POINT_LATE_PARAMS['too_late'])
    end

    it "has late_by" do
      expect(way_point_late.late_by).to eq(Factory::WAY_POINT_LATE_PARAMS['late_by'])
    end
  end
end
