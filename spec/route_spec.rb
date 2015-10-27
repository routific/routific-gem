require_relative './helper/spec_helper'

describe RoutificApi::Route do
  subject(:route) { Factory::ROUTE }

  it "has status" do
    expect(route.status).to eq(Factory::ROUTE_STATUS)
  end

  it "has fitness" do
    expect(route.fitness).to eq(Factory::ROUTE_FITNESS)
  end

  it "has unserved" do
    expect(route.unserved).to eq(Factory::ROUTE_UNSERVED)
  end

  describe "#vehicleRoutes" do
    it "is a Hash" do
      expect(route.vehicleRoutes).to be_instance_of(Hash)
    end
  end

  describe "#addWayPoint" do
    before do
      route.addWayPoint(Factory::VEHICLE_NAME, Factory::WAY_POINT)
    end

    it "creates a new key in vehicleRoutes" do
      expect(route.vehicleRoutes).to include(Factory::VEHICLE_NAME)
    end

    it "stores new waypoint into vehicleRoutes" do
      expect(route.vehicleRoutes[Factory::VEHICLE_NAME]).to include(Factory::WAY_POINT)
    end
  end
end
