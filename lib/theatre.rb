# frozen_string_literal: true

class Theatre
  def initialize(rows = 100)
    @all_seats = Array.new(rows) { Row.new }
  end

  def row(row)
    assert_valid_row_number(row)
    @all_seats[row]
  end

  def seat(row, seat)
    assert_valid_row_number(row)
    assert_valid_seat_number(seat)
    @all_seats[row].seats[seat]
  end

  def rows
    @all_seats
  end

  def seat_available?(row, seat)
    rows[row].seats[seat].available?
  end

  private

  def assert_valid_row_number(row)
    raise InvalidRowNumberError if row.negative? || row > rows.count
  end

  def assert_valid_seat_number(seat)
    raise InvalidSeatNumberError if seat.negative? || seat > row(0).seats.count
  end
end
