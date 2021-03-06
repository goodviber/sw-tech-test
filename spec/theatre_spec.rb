# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Theatre do
  subject { Theatre.new }

  describe '#intialize' do
    it 'initializes a default theatre with 100 rows' do
      expect(subject.rows.size).to eq(100)
    end
  end

  describe '#row' do
    it 'returns a specific row' do
      expect(subject.row(0)).to be_an_instance_of(Row)
    end
  end

  describe '#seat' do
    it 'returns a specific seat' do
      expect(subject.seat(0, 0)).to be_an_instance_of(Seat)
    end
  end

  describe '#last_seat' do
    it 'returns the number of the last seat in the row' do
      expect(subject.last_seat).to eq(Row.new.number_of_seats - 1)
    end
  end

  describe '#seat_available?' do
    let(:seat) { subject.seat(0, 0) }
    it 'returns the availability of a specific seat' do
      expect(subject.seat_available?(0, 0)).to be(true)
      seat.reserve
      expect(subject.seat_available?(0, 0)).to be(false)
    end
  end
end
