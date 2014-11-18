require_relative './helper/spec_helper'

describe Location do
  describe "valid parameters" do
    subject(:visit) { Factory::VISIT }

    it "has start" do
      expect(visit.start).to eq(Factory::VISIT_START)
    end

    it "has end" do
      expect(visit.end).to eq(Factory::VISIT_END)
    end

    it "has duration" do
      expect(visit.duration).to eq(Factory::VISIT_DURATION)
    end

    it "has demand" do
      expect(visit.demand).to eq(Factory::VISIT_DEMAND)
    end

    describe "#as_json" do
      subject(:visitJSON) { visit.as_json() }

      it "can be reconverted to JSON" do
        expect { visitJSON }.to_not raise_error
      end

      it "has start" do
        expect(visitJSON["start"]).to eq(Factory::VISIT_START)
      end

      it "has end" do
        expect(visitJSON["end"]).to eq(Factory::VISIT_END)
      end

      it "has duration" do
        expect(visitJSON["duration"]).to eq(Factory::VISIT_DURATION)
      end

      it "has demand" do
        expect(visitJSON["demand"]).to eq(Factory::VISIT_DEMAND)
      end
    end
  end

  describe "empty parameters" do
    subject(:visit) { Visit.new({}) }

    it "does not raise any errors" do
      expect { visit }.to_not raise_error
    end

    describe "#as_json" do
      subject(:visitJSON) { visit.as_json }

      it "does not have start" do
        expect(visitJSON["start"]).to be_nil
      end

      it "does not have end" do
        expect(visitJSON["end"]).to be_nil
      end

      it "does not have duration" do
        expect(visitJSON["duration"]).to be_nil
      end

      it "does not have demand" do
        expect(visitJSON["demand"]).to be_nil
      end
    end
  end
end
