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
      BookingRequestRule.new() do |rejections|
        if row_match(booking_request) &&
          not_second_seat(booking_request) &&
          not_second_last_seat(booking_request, theatre) &&
          all_seats_available(booking_request, theatre) &&
          seat_allowance(booking_request)
        else
          rejections << booking_request
        end
        puts rejections.size
      end
    end

    def row_match(booking_request)
      booking_request.start_row == booking_request.end_row
    end

    def seat_allowance(booking_request)
      (booking_request.first_seat..booking_request.last_seat).size <= 5
    end

    def not_second_seat(booking_request)
      booking_request.first_seat != 1
    end

    def not_second_last_seat(booking_request, theatre)
      booking_request.last_seat != theatre.row(0).number_of_seats - 2
    end

    def all_seats_available(booking_request, theatre)
      (booking_request.first_seat..booking_request.last_seat).each do |seat|
        s = theatre.seat(booking_request.start_row, seat)
        return false if s.availability? == false
      end
    end


  end
end