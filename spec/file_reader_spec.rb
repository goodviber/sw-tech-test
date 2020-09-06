# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FileReader do
  subject { FileReader.new }
  let(:read_the_file) { subject.read_the_file('spec/fixtures/test_file') }

  describe '#initialize' do
    it 'initializes with instance variable bookings_array' do
      expect(subject.bookings_array).to eq([])
    end
  end

  describe '#read_the_file' do
    it 'reads a file of booking request data and appends to bookings_array as arrays' do
      read_the_file
      expect(subject.bookings_array).to eq([[379, 18, 5, 18, 6], [380, 64, 41, 64, 41]])
    end
  end

  describe '#hash_booking' do
    let(:booking) { [379, 18, 5, 18, 6] }
    it 'transposes a bookings_array element to a hash' do
      expect(subject.hash_booking(booking)).to eq({:end_row=>18, :first_seat=>5, :id=>379, :last_seat=>6, :start_row=>18})
    end
  end

  describe '#hash_bookings_array' do
    it 'processes all bookings_array elements to hashes' do
      read_the_file
      subject.hash_bookings_array
      expect(subject.bookings_array).to eq([{:end_row=>18, :first_seat=>5, :id=>379, :last_seat=>6, :start_row=>18}, {:end_row=>64, :first_seat=>41, :id=>380, :last_seat=>41, :start_row=>64}])
    end
  end

  describe '#create_booking_requests' do
    it 'processes all hashed bookings_array elements as BookingRequests' do
      read_the_file
      subject.hash_bookings_array
      subject.create_booking_requests
      expect(subject.bookings_array.first).to be_an_instance_of(BookingRequest)
      expect(subject.bookings_array.size).to eq(2)
    end
  end
end