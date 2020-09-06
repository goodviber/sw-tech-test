# frozen_string_literal: true

class BookingManager
  attr_reader :booking_requests, :file_reader, :theatre, :rejections, :current_booking

  def initialize(file_reader, theatre)
    @booking_requests = file_reader.bookings_array
    @theatre = theatre
    @rejections = []
  end

  def seat_available?(row, seat)
    theatre.seat_available?(row, seat)
  end

  def session_booking(booking_request)
    @current_booking = booking_request.seats
  end

  def last_row
    @theatre.rows.size - 1
  end

  def last_seat
    @theatre.rows[0].seats.size - 1
  end

  def requested_seats_available?
    seats = theatre.seat(current_booking[:row], current_booking[:seat_range])
    seats_available?(seats)
  end

  def no_single_seat_gap?
    return false if first == 1 && theatre.seat(row, 0).available? ||
                    last == 48 && theatre.seat(row, 49).available? ||
                    first > 1 && right_single_gap ||
                    last < 48 && left_single_gap

    true
  end

  def validate(booking_request)
    session_booking(booking_request)
    booking_request.valid? &&
      requested_seats_available? &&
      no_single_seat_gap?
  end

  def reserve_seats
    theatre_seats = theatre.rows[current_booking[:row]].seats
    current_booking[:seat_range].each { |seat| theatre_seats[seat].reserve }
  end

  def process_booking_requests
    booking_requests.each do |request|
      if validate(request)
        reserve_seats
      else
        rejections.push request
      end
    end
  end

  private

  def row
    current_booking[:row]
  end

  def first
    current_booking[:seat_range].first
  end

  def last
    current_booking[:seat_range].last
  end

  def right_single_gap
    theatre.seat(row, first - 1).available? &&
      !theatre.seat(row, first - 2).available?
  end

  def left_single_gap
    theatre.seat(row, last + 1).available? &&
      !theatre.seat(row, last + 2).available?
  end

  def seats_available?(seats)
    seats.all?(&:available?)
  end
end
