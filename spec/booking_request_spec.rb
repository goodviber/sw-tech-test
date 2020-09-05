# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BookingRequest do
  subject { BookingRequest.new({id: 0, start_row: 47, first_seat: 39, end_row: 47, last_seat: 41}) }

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
end
