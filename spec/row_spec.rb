require 'spec_helper'

RSpec.describe Seat do
  subject { Row.new }

  describe "initialize" do
    it "creates a row of 50 seats" do
      byebug
      expect(subject.seats.size).to eq(50)
    end
  end
end