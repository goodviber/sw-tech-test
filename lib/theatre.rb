# frozen_string_literal: true

class Theatre
  def initialize(rows = 100)
    @all_seats = Array.new(rows) { Row.new }
  end

  def row(row)
    @all_seats[row]
  end

  def seat(row, seat)
    @all_seats[row].seats[seat]
  end

  def rows
    @all_seats
  end

  def seat_available?(row, seat)
    rows[row].seats[seat].available?
  end

  private

end
