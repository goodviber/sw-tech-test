require 'spec_helper'

RSpec.describe Seat do
  subject { Seat.new }

  describe "#availability?" do
    it "returns the available status" do
      expect(subject.availability?).to eq(true)
    end
  end

  describe "reserve" do
    it "reserves the seat" do
      subject.reserve
      expect(subject.availability?).to eq(false)
    end
  end
end