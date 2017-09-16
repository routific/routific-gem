require_relative './helper/spec_helper'
require_relative '../lib/util'

describe Routific do
  describe "instance objects" do
    Routific.setToken(ENV["API_KEY"])
    subject(:routific) { Routific.new() }

    it "has token" do
      expect(routific.token).to eq(Util.prefix_token(ENV["API_KEY"]))
    end

    describe "#visits" do
      it "is instance of a Hash" do
        expect(routific.visits).to be_instance_of(Hash)
      end
    end

    describe "#fleet" do
      it "is instance of a Hash" do
        expect(routific.fleet).to be_instance_of(Hash)
      end
    end

    describe "#options" do
      it "is instance of a Routific::Options" do
        routific.setOptions(Factory::ROUTE_OPTIONS_PARAMS)
        expect(routific.options).to be_instance_of(RoutificApi::Options)
      end
    end

    describe "#setVisit" do
      let(:id) { Faker::Lorem.word }
      before do
        routific.setVisit(id, Factory::VISIT_PARAMS)
      end

      it "adds location 1 into visits" do
        expect(routific.visits).to include(id)
      end

      it "location 1 in visits is instances of Visit" do
        expect(routific.visits[id]).to be_instance_of(RoutificApi::Visit)
      end
    end

    describe "#setVehicle" do
      let(:id) { Faker::Lorem.word }

      before do
        routific.setVehicle(id, Factory::VEHICLE_PARAMS)
      end

      it "adds vehicle into fleet" do
        expect(routific.fleet).to include(id)
      end

      it "vehicle in fleet is instances of Vehicle" do
        expect(routific.fleet[id]).to be_instance_of(RoutificApi::Vehicle)
      end
    end

    describe "#setOptions" do
      before do
        routific.setOptions(Factory::ROUTE_OPTIONS_PARAMS)
      end

      it "adds an options hash into options" do
        expect(routific.options.traffic).to eq(Factory::ROUTE_OPTIONS_TRAFFIC)
        expect(routific.options.min_visits_per_vehicle).to eq(Factory::ROUTE_OPTIONS_MIN_VISITS_PER_VEHICLE)
        expect(routific.options.balance).to eq(Factory::ROUTE_OPTIONS_BALANCE)
        expect(routific.options.min_vehicles).to eq(Factory::ROUTE_OPTIONS_MIN_VEHICLES)
        expect(routific.options.shortest_distance).to eq(Factory::ROUTE_OPTIONS_SHORTEST_DISTANCE)
      end

      it "options is instance of RoutificApi::Options" do
        expect(routific.options).to be_instance_of(RoutificApi::Options)
      end
    end

    def set_visit_and_vehicle(routific)
      routific.setVisit("order_1", {
        "start" => "9:00",
        "end" => "12:00",
        "duration" => 10,
        "location" => {
          "name" => "6800 Cambie",
          "lat" => 49.227107,
          "lng" => -123.1163085,
        }
      })

      routific.setVehicle("vehicle_1", {
        "start_location" => {
          "name" => "800 Kingsway",
          "lat" => 49.2553636,
          "lng" => -123.0873365,
        },
        "end_location" => {
          "name" => "800 Kingsway",
          "lat" => 49.2553636,
          "lng" => -123.0873365,
        },
        "shift_start" => "8:00",
        "shift_end" => "12:00",
      })
    end

    describe "#getRoute" do
      before do
        set_visit_and_vehicle routific
      end

      it "returns a Route instance" do
        route = routific.getRoute()
        expect(route).to be_instance_of(RoutificApi::Route)
      end

      it "attaches optional data hash" do
        routific.setOptions({
          "traffic" => "slow"
        })

        data = {
          visits: routific.visits,
          fleet: routific.fleet,
          options: routific.options
        }

        route = routific.getRoute()
        expect(route).to be_instance_of(RoutificApi::Route)
      end
    end

    describe "#get_route_async" do
      before do
        job = nil
        set_visit_and_vehicle routific
      end

      it "returns a Job instance" do
        job = routific.get_route_async()
        expect(job).to be_instance_of(RoutificApi::Job)
        expect(job.id).to be_instance_of(String)
        expect(job.input).to be_instance_of(Hash)
        expect(job.status).to eq('pending')
        sleep 1
        expect(job.fetch).to eq('finished')
        expect(job.route).to be_instance_of(RoutificApi::Route)
      end
    end
  end

  describe "class methods" do
    describe ".setToken" do
      before do
        Routific.setToken(ENV["API_KEY"])
      end

      it "sets default Routific API token" do
        expect(Routific.token).to eq(Util.prefix_token(ENV["API_KEY"]))
      end
    end
  end
end
