require 'spec_helper'

RSpec.describe Row do
  subject { Row.new(50) }

  describe "initialize" do
    it "initializes a row of 50 seats" do
      expect(subject.number_of_seats).to eq(50)
    end
  end
end