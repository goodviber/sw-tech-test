class Row
  attr_reader :seats, :number_of_seats

  def initialize(number_of_seats = 50)
    @number_of_seats = number_of_seats
    @seats = Array.new(number_of_seats) { Seat.new }
  end

end