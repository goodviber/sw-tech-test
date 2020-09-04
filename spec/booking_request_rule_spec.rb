# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BookingRequestRule do
  let(:booking_request) { BookingRequest.new(0, 47, 39, 47, 41) }
  let(:theatre) { Theatre.new }
  subject { BookingRequestRule.valid_booking?(booking_request, theatre) }

  describe '#initialize?' do
    it 'initializes a BookingRequestRule' do
      expect(subject).to be_a_kind_of(BookingRequestRule)
    end
  end

  describe '#valid_booking?' do
    describe '#all_requested_seats_available' do
      context 'with all seats available' do
        it 'accepts the booking request' do
          expect(described_class.all_requested_seats_available(booking_request, theatre)).to be_truthy
          expect { subject.apply }.to output("0\n").to_stdout
        end
      end

      context 'with a reserved seat' do
        let(:seat) { theatre.seat(47, 39) }
        it 'rejects the the booking_request' do
          seat.reserve
          expect(described_class.all_requested_seats_available(booking_request, theatre)).to be(false)
          expect { subject.apply }.to output("1\n").to_stdout
        end
      end
    end

    describe '#row_match' do
      context 'when spanning multiple rows' do
        let(:booking_request) { BookingRequest.new(0, 47, 39, 46, 41) }
        it 'rejects the the booking_request' do
          expect(described_class.row_match(booking_request)).to be(false)
          expect { subject.apply }.to output("1\n").to_stdout
        end
      end
    end

    describe '#within_row' do
      context 'within the row' do
        it 'accepts the booking_request' do
          expect(described_class.within_row(booking_request)).to be_truthy
          expect { subject.apply }.to output("0\n").to_stdout
        end
      end

      context 'not within the row' do
        let(:booking_request) { BookingRequest.new(0, 47, 48, 47, 51) }
        it 'rejects the booking_request' do
          expect(described_class.within_row(booking_request)).to be(false)
          expect { subject.apply }.to output("1\n").to_stdout
        end
      end
    end

    describe '#within_theatre' do
      context 'within the theatre rows' do
        it 'accepts the booking_request' do
          expect(described_class.within_theatre(booking_request)).to be_truthy
          expect { subject.apply }.to output("0\n").to_stdout
        end
      end

      context 'not within the theatre rows' do
        let(:booking_request) { BookingRequest.new(0, 100, 48, 47, 48) }
        it 'rejects the booking_request' do
          expect(described_class.within_theatre(booking_request)).to be(false)
          expect { subject.apply }.to output("1\n").to_stdout
        end
      end
    end

    describe '#seats_in_order' do
      context 'with seats in order' do
        it 'accepts the booking_request' do
          expect(described_class.seats_in_order(booking_request)).to be_truthy
          expect { subject.apply }.to output("0\n").to_stdout
        end
      end

      context 'with seats in reverse order' do
        let(:booking_request) { BookingRequest.new(0, 47, 40, 47, 36) }
        it 'rejects the booking_request' do
          expect(described_class.seats_in_order(booking_request)).to be(false)
          expect { subject.apply }.to output("1\n").to_stdout
        end
      end
    end

    describe '#no_single_seat_gap' do
      context 'with no single seat gap' do
        let(:booking_request) { BookingRequest.new(0, 47, 0, 47, 4) }
        it 'accepts the booking_request' do
          expect(described_class.no_single_seat_gap(booking_request, theatre)).to be_truthy
          expect { subject.apply }.to output("0\n").to_stdout
        end
      end

      context 'with single seat gap at start of row' do
        let(:booking_request) { BookingRequest.new(0, 47, 1, 47, 4) }
        it 'rejects the booking_request' do
          expect(described_class.no_single_seat_gap(booking_request, theatre)).to be(false)
          expect { subject.apply }.to output("1\n").to_stdout
        end
      end

      context 'with single seat gap at end of row' do
        let(:booking_request) { BookingRequest.new(0, 47, 45, 47, 48) }
        it 'rejects the booking_request' do
          expect(described_class.no_single_seat_gap(booking_request, theatre)).to be(false)
          expect { subject.apply }.to output("1\n").to_stdout
        end
      end

      context 'with single seat gap within row on start side' do
        let(:booking_request) { BookingRequest.new(0, 47, 5, 47, 9) }
        let(:seat) { theatre.seat(47, 3) }
        it 'rejects the booking request' do
          seat.reserve
          expect(described_class.no_single_seat_gap(booking_request, theatre)).to be(false)
          expect { subject.apply }.to output("1\n").to_stdout
        end
      end

      context 'with single seat gap within row on end side' do
        let(:booking_request) { BookingRequest.new(0, 47, 5, 47, 9) }
        let(:seat) { theatre.seat(47, 11) }
        it 'rejects the booking request' do
          seat.reserve
          expect(described_class.no_single_seat_gap(booking_request, theatre)).to be(false)
          expect { subject.apply }.to output("1\n").to_stdout
        end
      end
    end

  end
end
