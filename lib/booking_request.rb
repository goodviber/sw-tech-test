class BookingRequest
  attr_reader :id, :start_row, :first_seat, :end_row, :last_seat

  def initialize(params = {})
    @id = params.fetch :id
    @start_row = params.fetch :start_row
    @first_seat = params.fetch :first_seat
    @end_row = params.fetch :end_row
    @last_seat = params.fetch :last_seat
  end

  def row_match
    start_row == end_row
  end

  def max_seat_allowance
    (first_seat..last_seat).size <= 5
  end

  def within_row
    first_seat >= 0 && last_seat <= 49
  end

  def within_theatre
    start_row >= 0 && start_row <= 99
  end

  def seats_in_order
    first_seat < last_seat
  end

end