require_relative './helper/spec_helper'

describe Routific do
  describe "instance objects" do
    subject(:routific) { Routific.new(ENV["API_KEY"]) }

    it "has token" do
      expect(routific.token).to eq(ENV["API_KEY"])
    end

    describe "#network" do
      it "is instance of a Hash" do
        expect(routific.network).to be_instance_of(Hash)
      end
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

    describe "#setLocation" do
      before do
        routific.setLocation(Factory::LOCATION_1_ID, Factory::LOCATION_PARAMS)
      end

      it "adds location 1 into network" do
        expect(routific.network).to include(Factory::LOCATION_1_ID)
      end

      it "location 1 in network is instances of Location" do
        expect(routific.network[Factory::LOCATION_1_ID]).to be_instance_of(Location)
      end
    end

    describe "#setVisit" do
      before do
        routific.setVisit(Factory::LOCATION_1_ID, Factory::VISIT_PARAMS)
      end

      it "adds location 1 into visits" do
        expect(routific.visits).to include(Factory::LOCATION_1_ID)
      end

      it "location 1 in visits is instances of Visit" do
        expect(routific.visits[Factory::LOCATION_1_ID]).to be_instance_of(Visit)
      end
    end

    describe "#setVehicle" do
      before do
        routific.setVehicle(Factory::VEHICLE_NAME, Factory::VEHICLE_PARAMS)
      end

      it "adds vehicle into fleet" do
        expect(routific.fleet).to include(Factory::VEHICLE_NAME)
      end

      it "vehicle in fleet is instances of Vehicle" do
        expect(routific.fleet[Factory::VEHICLE_NAME]).to be_instance_of(Vehicle)
      end
    end

    describe "#getRoute" do
      before do
        routific.setLocation("order_1", {
          "name" => "6800 Cambie",
          "lat" => 49.227107,
          "lng" => -123.1163085,
        })

        routific.setLocation("depot", {
          "name" => "800 Kingsway",
          "lat" => 49.2553636,
          "lng" => -123.0873365,
        })

        routific.setVisit("order_1", {
          "start" => "9:00",
          "end" => "12:00",
          "duration" => 10,
        })

        routific.setVehicle("vehicle_1", {
          "start_location" => "depot",
          "end_location" => "depot",
          "shift_start" => "8:00",
          "shift_end" => "12:00",
        })
      end

      it "returns a Route instance" do
        route = routific.getRoute() 
        expect(route).to be_instance_of(Route)
      end
    end
  end

  describe "class methods" do
    describe ".setToken" do
      before do
        Routific.setToken(ENV["API_KEY"])
      end

      it "sets default Routific API token" do
        expect(Routific.token).to eq(ENV["API_KEY"])
      end
    end

    describe ".getRoute" do
      describe "access token is nil" do
        it "throws an ArgumentError" do
          expect { Routific.getRoute({}, nil) }.to raise_error(ArgumentError)
        end
      end

      describe "valid access token" do
        before do
          network = {
            "order_1" => {
              "name" => "6800 Cambie",
              "lat" => 49.227107,
              "lng" => -123.1163085
            },
            "depot" => {
              "name" => "800 Kingsway",
              "lat" => 49.2553636,
              "lng" => -123.0873365
            }
          }
          visits = {
            "order_1" => {
              "start" => "9:00",
              "end" => "12:00",
              "duration" => 10
            }
          }
          fleet = {
            "vehicle_1" => {
              "start-location" => "depot",
              "end-location" => "depot",
              "shift-start" => "8:00",
              "shift-end" => "12:00"
            }
          }
          @data = {
            network: network,
            visits: visits,
            fleet: fleet
          }
        end

        describe "access token is set" do
          before do
            Routific.setToken(ENV["API_KEY"])
          end

          it "returns a Route instance" do
            expect(Routific.getRoute(@data)).to be_instance_of(Route)
          end
        end

        describe "access token is provided" do
          before do
            Routific.setToken(nil)
          end

          it "returns a Route instance" do
            expect(Routific.getRoute(@data, ENV["API_KEY"])).to be_instance_of(Route)
          end
        end
      end
    end
  end
end