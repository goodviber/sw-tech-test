# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BookingManager do
  let(:file_reader) { FileReader.new }
  let(:theatre) { Theatre.new }
  subject { BookingManager.new(file_reader, theatre) }

  let(:valid_booking_request) { BookingRequest.new(end_row: 18, first_seat: 5, id: 379, last_seat: 6, start_row: 18) }
  let(:invalid_booking_request) { BookingRequest.new(end_row: 18, first_seat: 5, id: 379, last_seat: 16, start_row: 18) }
  let(:start_space_booking_request) { BookingRequest.new(end_row: 18, first_seat: 1, id: 379, last_seat: 5, start_row: 18) }
  let(:end_space_booking_request) { BookingRequest.new(end_row: 18, first_seat: 44, id: 379, last_seat: 48, start_row: 18) }

  before(:each) do
    file_reader.read_the_file('bookings/sample_booking_requests')
    file_reader.hash_bookings_array
    file_reader.create_booking_requests
  end

  describe '#initialize' do
    it 'initialises with booking_requests, theatre and rejections' do
      expect(subject).to be_an_instance_of(BookingManager)
      expect(subject.rejections).to eq([])
      expect(subject.booking_requests).to be_a(Array)
      expect(subject.booking_requests.first).to be_an_instance_of(BookingRequest)
      expect(subject.theatre).to be_an_instance_of(Theatre)
    end
  end

  describe '#seat_available?' do
    let(:seat) { subject.theatre.seat(0, 0) }
    it 'returns the availability of a specific seat' do
      expect(subject.seat_available?(0, 0)).to be true
      seat.reserve
      expect(subject.seat_available?(0, 0)).to be(false)
    end
  end

  describe '#session_booking' do
    it 'returns a specific booking request row and seat range' do
      expect(subject.session_booking(valid_booking_request)).to eq(row: 18, seat_range: 5..6)
    end
  end


  describe '#requested_seats_available?' do
    it 'checks the availablity of the requested seats' do
      subject.session_booking(valid_booking_request)
      expect(subject.requested_seats_available?).to be true
    end
  end

  describe '#no_single_seat_gap?' do
    context 'start row' do
      let(:seat) { subject.theatre.seat(18, 0) }
      it 'checks for a single gap at start of row' do
        subject.session_booking(start_space_booking_request)
        expect(subject.no_single_seat_gap?).to be false
        seat.reserve
        expect(subject.no_single_seat_gap?).to be true
      end
    end

    context 'end row' do
      let(:seat) { subject.theatre.seat(18, 49) }
      it 'checks for a single gap at end of row' do
        subject.session_booking(end_space_booking_request)
        expect(subject.no_single_seat_gap?).to be false
        seat.reserve
        expect(subject.no_single_seat_gap?).to be true
      end
    end

    context 'within row' do
      let(:seat) { subject.theatre.seat(18, 3) }
      it 'checks for single gap within row' do
        subject.session_booking(valid_booking_request)
        expect(subject.no_single_seat_gap?).to be true
        seat.reserve
        expect(subject.no_single_seat_gap?).to be false
      end
    end
  end

  describe '#validate' do
    it 'validates the current booking against rules' do
      expect(subject.validate(valid_booking_request)).to be true
      expect(subject.validate(invalid_booking_request)).to be false
    end
  end

  describe '#reserve_seats' do
    it 'reserves the BookingRequest range of seats' do
      subject.session_booking(valid_booking_request)
      subject.reserve_seats
      expect(subject.seat_available?(18, 5)).to be false
      expect(subject.seat_available?(18, 6)).to be false
    end
  end

  describe '#process_booking_requests' do
    it 'rejects invalid bookings' do
      subject.process_booking_requests
      expect(subject.rejections.size).to eq 10
    end
  end
end
