require 'spec_helper'

RSpec.describe BookingRequestRule do
  let(:booking_request) { BookingRequest.new(0,47,39,47,41) }
  let(:theatre) { Theatre.new }
  subject { BookingRequestRule.valid_booking?(booking_request, theatre) }

  describe "#initialize?" do
    it "initializes a BookingRequestRule" do
      expect(subject).to be_a_kind_of(BookingRequestRule)
    end
  end

  describe "#valid_booking?" do
    context "with all seats available" do
      it "does not reject the booking" do
        expect{ (subject.apply) }.to output("0\n").to_stdout
      end
    end

    context "with a reserved seat" do
      let(:seat) { theatre.seat(47,39) }
      it "rejects the the booking_request" do
        seat.reserve
        expect{ (subject.apply) }.to output("1\n").to_stdout
      end
    end

    context "with multiple rows" do
      let(:booking_request) { BookingRequest.new(0,47,39,46,41) }
      it "rejects the the booking_request" do
        expect{ (subject.apply) }.to output("1\n").to_stdout
      end
    end

    context "with seats in second place" do
      let(:booking_request) { BookingRequest.new(0,47,1,47,4) }
      it "rejects the the booking_request" do
        expect{ (subject.apply) }.to output("1\n").to_stdout
      end
    end

    context "with seats in second last place" do
      let(:booking_request) { BookingRequest.new(0,47,44,47,48) }
      it "rejects the the booking_request" do
        expect{ (subject.apply) }.to output("1\n").to_stdout
      end
    end

  end
end