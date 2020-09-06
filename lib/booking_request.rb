# frozen_string_literal: true

class BookingRequest
  attr_accessor :id, :start_row, :first_seat, :end_row, :last_seat, :seats

  MAX_SEATING_ALLOWANCE = 5

  def initialize(params = {})
    @id = params.fetch :id
    @start_row = params.fetch :start_row
    @first_seat = params.fetch :first_seat
    @end_row = params.fetch :end_row
    @last_seat = params.fetch :last_seat
    @seats = {
      row: @start_row, seat_range: (@first_seat..@last_seat)
    }
  end

  def valid?
    row_match? &&
      max_seat_allowance? &&
      within_row? &&
      within_theatre? &&
      seats_in_order?
  end

  def row_match?
    start_row == end_row
  end

  def max_seat_allowance?
    (first_seat..last_seat).size <= MAX_SEATING_ALLOWANCE
  end

  def within_row?
    first_seat >= 0 && last_seat <= Row.new.number_of_seats - 1
  end

  def within_theatre?
    start_row >= 0 && start_row <= Theatre.new.rows.size - 1
  end

  def seats_in_order?
    first_seat <= last_seat
  end
end
