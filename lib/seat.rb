class Seat
  def initialize
    @available = true
  end

  def availability?
    @available
  end

  def reserve
    @available = false
    self
  end

  def cancel
    @available = true
    self
  end
end