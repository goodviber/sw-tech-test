# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Row do
  subject { Row.new(50) }

  describe 'initialize' do
    it 'initializes a default row of 50 seats' do
      expect(subject.number_of_seats).to eq(50)
    end

    it 'has individual instances of seats' do
      expect(subject.seats[0]).not_to eq(subject.seats[1])
    end
  end
end
