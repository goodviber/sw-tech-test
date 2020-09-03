class InvalidRowNumberError < StandardError
  def message
    "A row must be within the correct range"
  end
end

class InvalidSeatNumberError < StandardError
  def message
    "A seat must be within the correct range"
  end
end
