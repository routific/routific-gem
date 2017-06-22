require_relative './helper/spec_helper'

describe RoutificApi::Route do
  subject(:route) { Factory::ROUTE }

  it "has status" do
    expect(route.status).to eq(Factory::ROUTE_STATUS)
  end

  it "has total_travel_time" do
    expect(route.total_travel_time).to eq(Factory::ROUTE_TOTAL_TRAVEL_TIME)
  end

  it "has total_idle_time" do
    expect(route.total_idle_time).to eq(Factory::ROUTE_TOTAL_IDLE_TIME)
  end

  it "has unserved" do
    expect(route.unserved).to eq(Factory::ROUTE_UNSERVED)
  end

  it "has number_of_unserved" do
    expect(route.number_of_unserved).to eq(Factory::ROUTE_UNSERVED.count)
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
