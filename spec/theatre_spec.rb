require 'spec_helper'

RSpec.describe Theatre do
  subject { Theatre.new }

  describe "intialize" do
    it "initializes a theatre with 100 rows" do
      expect(subject.rows.size).to eq(100)
    end
  end

  describe "row" do
    it "returns a specific row" do
      expect(subject.row(0)).to be_an_instance_of(Row)
    end
    it "raises an error with invalid row numbers" do
      expect { subject.row(1000) }.to raise_error(InvalidRowNumberError)
    end
  end

  describe "seat" do
    it "returns a specific seat" do
      expect(subject.seat(0,0)).to be_an_instance_of(Seat)
    end
    it "raises an error with invalid seat numbers" do
      expect { subject.seat(0,1000) }.to raise_error(InvalidSeatNumberError)
    end
  end
end