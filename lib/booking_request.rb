class BookingRequest
  attr_reader :id, :start_row, :first_seat, :end_row, :last_seat

  def initialize(id, start_row, first_seat, end_row, last_seat)
    @id = id
    @start_row = start_row
    @first_seat = first_seat
    @end_row = end_row
    @last_seat = last_seat
  end

end