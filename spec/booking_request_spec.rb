# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BookingRequest do
  subject { BookingRequest.new ({id: 0, start_row: 47, first_seat: 39, end_row: 47, last_seat: 41}) }

  describe '#initialize' do
    it 'initializes a BookingRequest' do
      expect(subject).to be_an_instance_of(BookingRequest)
      expect(subject.id).to be(0)
      expect(subject.start_row).to be(47)
      expect(subject.first_seat).to be(39)
      expect(subject.end_row).to be(47)
      expect(subject.last_seat).to be(41)
    end
  end

  describe '#row_match?' do
    it 'checks seats are in the same row' do
      expect(subject.row_match?).to be true
      subject.end_row = 48
      expect(subject.row_match?).to be(false)
    end
  end

  describe '#max_seat_allowance?' do
    it 'checks number of seats requested within limit' do
      expect(subject.max_seat_allowance?).to be true
      subject.last_seat = 48
      expect(subject.max_seat_allowance?).to be(false)
    end
  end

  describe '#within_row?' do
    it 'checks the seats are within the row size' do
      expect(subject.within_row?).to be true
      subject.last_seat = 51
      expect(subject.within_row?).to be(false)
    end
  end

  describe '#within_theatre?' do
    it 'checks the seats are within the theatre rows' do
      expect(subject.within_theatre?).to be true
      subject.start_row = 101
      expect(subject.within_theatre?).to be(false)
    end
  end

  describe '#seats_in_order?' do
    it 'checks the seats are in ascending order' do
      expect(subject.seats_in_order?).to be true
      subject.last_seat = 35
      expect(subject.seats_in_order?).to be(false)
    end
  end

  describe '#valid?' do
    it 'checks the validation rules' do
      expect(subject.valid?).to be true
      subject.last_seat = 51
      expect(subject.valid?).to be(false)
    end
  end

end
