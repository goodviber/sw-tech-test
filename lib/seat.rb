class Seat
  def initialize
    @available = true
  end

  def available?
    @available
  end

  def reserve
    @available = false
    self
  end

end