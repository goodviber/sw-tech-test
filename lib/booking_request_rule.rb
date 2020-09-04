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
           #not_second_seat(booking_request, theatre) &&
           #not_second_last_seat(booking_request, theatre) &&
           all_requested_seats_available(booking_request, theatre) &&
           max_seat_allowance(booking_request)
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

    def not_second_seat(booking_request, theatre)
      booking_request.first_seat != 1 && theatre.seat(booking_request.start_row, booking_request.first_seat-1).availability? == false
    end

    def not_second_last_seat(booking_request, theatre)
      booking_request.last_seat != theatre.row(0).number_of_seats - 2 && theatre.seat(booking_request.start_row,  theatre.row(0).number_of_seats-1).availability?
    end

    def all_requested_seats_available(booking_request, theatre)
      (booking_request.first_seat..booking_request.last_seat).each do |seat|
        s = theatre.seat(booking_request.start_row, seat)
        return false if s.availability? == false
      end
    end

    def within_row
      booking_request.first_seat >= 0 && booking_request.last_seat <= 49
    end


  end
end
