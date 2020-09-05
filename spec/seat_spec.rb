# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Seat do
  subject { Seat.new }

  describe '#available?' do
    it 'returns the available status' do
      expect(subject.available?).to eq(true)
    end
  end

  describe 'reserve' do
    it 'reserves the seat' do
      subject.reserve
      expect(subject.available?).to eq(false)
    end
  end
end
