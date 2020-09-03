class Theatre
  def initialize(rows = 100)
    @all_seats = Array.new(rows){ Row.new }
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

  private

  def assert_valid_row_number(row)
    raise InvalidRowNumberError if row < 0 || row > rows.count
  end

  def assert_valid_seat_number(seat)
    raise InvalidSeatNumberError if seat < 0 || seat > 50
  end
end
