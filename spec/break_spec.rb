require_relative './helper/spec_helper'

describe RoutificApi::Break do
  describe "valid parameters" do
    subject(:brk) { Factory::BREAK }

    it "has id" do
      expect(brk.id).to eq(Factory::BREAK_ID)
    end

    it "has start" do
      expect(brk.start).to eq(Factory::BREAK_START)
    end

    it "has end" do
      expect(brk.end).to eq(Factory::BREAK_END)
    end

    it "has in_transit" do
      expect(brk.in_transit).to eq(Factory::BREAK_IN_TRANSIT)
    end

    describe "#as_json" do
      subject(:breakJSON) { brk.as_json }

      it "has id" do
        expect(breakJSON["id"]).to eq(Factory::BREAK_ID)
      end

      it "has start" do
        expect(breakJSON["start"]).to eq(Factory::BREAK_START)
      end

      it "has end" do
        expect(breakJSON["end"]).to eq(Factory::BREAK_END)
      end

      it "has in_transit" do
        expect(breakJSON["in_transit"]).to eq(Factory::BREAK_IN_TRANSIT)
      end
    end
  end

  describe "missing id" do
    subject(:brk) { RoutificApi::Break.new({
      "start"      => Factory::BREAK_START,
      "end"        => Factory::BREAK_END,
      "in_transit" => Factory::BREAK_IN_TRANSIT,
      }) }

    it "raises an ArgumentError" do
      expect { brk }.to raise_error(ArgumentError)
    end
  end

  describe "missing start" do
    subject(:brk) { RoutificApi::Break.new({
      "id"         => Factory::BREAK_ID,
      "end"        => Factory::BREAK_END,
      "in_transit" => Factory::BREAK_IN_TRANSIT,
      }) }

    it "raises an ArgumentError" do
      expect { brk }.to raise_error(ArgumentError)
    end
  end

  describe "missing end" do
    subject(:brk) { RoutificApi::Break.new({
      "id"         => Factory::BREAK_ID,
      "start"      => Factory::BREAK_START,
      "in_transit" => Factory::BREAK_IN_TRANSIT,
      }) }

    it "raises an ArgumentError" do
      expect { brk }.to raise_error(ArgumentError)
    end
  end

  describe "missing in transit" do
    subject(:brk) { RoutificApi::Break.new({
      "id"         => Factory::BREAK_ID,
      "start"      => Factory::BREAK_START,
      "end"        => Factory::BREAK_END,
      }) }

    it "does not raise any error" do
      expect { brk }.to_not raise_error
    end
  end
end
