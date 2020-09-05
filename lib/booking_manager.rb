class BookingManager
  attr_reader :booking_request_rules

  def initialize(booking_request_rules = [])
    @booking_request_rules = booking_request_rules
  end

  def process(booking_request)
    booking_request_rules.each do |rule|
      rule.apply(booking_request)
    end
  end
end