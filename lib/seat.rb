class Seat
  def initialize
    @available = true
  end

  def availability?
    @available
  end

  def reserve
    @available = false
  end
end