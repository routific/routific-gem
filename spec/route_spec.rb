require_relative './helper/spec_helper'

describe RoutificApi::Route do
  subject(:route) { Factory::ROUTE }

  Factory::ROUTE_INPUT.each do |key, value|
    it "has #{key}" do
      expect(eval("route.#{key}")).to eq(value)
    end
  end

  describe "#vehicleRoutes" do
    it "is a Hash" do
      expect(route.vehicleRoutes).to be_instance_of(Hash)
    end
  end

  describe "#add_way_point" do
    before do
      route.add_way_point(Factory::VEHICLE_NAME, Factory::WAY_POINT)
    end

    it "creates a new key in vehicleRoutes" do
      expect(route.vehicleRoutes).to include(Factory::VEHICLE_NAME)
    end

    it "stores new waypoint into vehicleRoutes" do
      expect(route.vehicleRoutes[Factory::VEHICLE_NAME]).to include(Factory::WAY_POINT)
    end
  end
end
