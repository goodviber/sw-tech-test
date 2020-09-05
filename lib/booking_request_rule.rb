# frozen_string_literal: true

class BookingRequestRule
  attr_reader :block

  def initialize(&block)
    @block = block
  end

  def apply(*args)
    block.call(args)
  end

  class << self
    def valid_booking?(booking_request, theatre)
        BookingRequestRule.new do |rejections|
          if row_match(booking_request) &&
            within_row(booking_request) &&
            within_theatre(booking_request) &&
            seats_in_order(booking_request) &&
            all_requested_seats_available(booking_request, theatre) &&
            max_seat_allowance(booking_request) &&
            no_single_seat_gap(booking_request, theatre)

            process_booking(booking_request, theatre)
          else
            rejections << booking_request
          end
          puts rejections.size
        end
    end

    def row_match(booking_request)
      booking_request.start_row == booking_request.end_row
    end

    def max_seat_allowance(booking_request)
      (booking_request.first_seat..booking_request.last_seat).size <= 5
    end

    def all_requested_seats_available(booking_request, theatre)
      (booking_request.first_seat..booking_request.last_seat).each do |seat|
        s = theatre.seat(booking_request.start_row, seat)
        return false if s.available? == false
      end
      true
    end

    def within_row(booking_request)
      booking_request.first_seat >= 0 && booking_request.last_seat <= 49
    end

    def within_theatre(booking_request)
      booking_request.start_row >= 0 && booking_request.start_row <= 99
    end

    def seats_in_order(booking_request)
      booking_request.first_seat < booking_request.last_seat
    end

    def no_single_seat_gap(booking_request, theatre)
      row = theatre.row(booking_request.start_row)
      seat_array = row.seats.map{ |seat| seat.available? ? 0 : 1 }

      return false if booking_request.first_seat == 1 && (seat_array[0]).zero? || booking_request.last_seat == 48 && (seat_array[49]).zero?

      return false if booking_request.first_seat > 1 && (seat_array[booking_request.first_seat - 1]).zero? && seat_array[booking_request.first_seat - 2] == 1

      return false if booking_request.last_seat < 48 && (seat_array[booking_request.last_seat + 1]).zero? && seat_array[booking_request.last_seat + 2] == 1

     true
    end

    def process_booking(booking_request, theatre)
      (booking_request.first_seat..booking_request.last_seat).each do |seat|
        s = theatre.seat(booking_request.start_row, seat)
        s.reserve
      end
    end
  end

end
