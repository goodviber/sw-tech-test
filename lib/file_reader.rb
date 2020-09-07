# frozen_string_literal: true

class FileReader
  attr_reader :bookings_array

  def initialize
    @bookings_array = []
  end

  def read_the_file(file_path)
    File.foreach(file_path) do |line|
      line_array = line.gsub(/\D/, ' ').split.map(&:to_i)
      bookings_array << line_array
    end
  end

  def hash_booking(booking)
    keys = %i[id start_row first_seat end_row last_seat]
    [keys, booking].transpose.to_h
  end

  def hash_bookings_array
    bookings_array.map! { |booking| hash_booking(booking) }
  end

  def create_booking_requests
    bookings_array.map! { |booking| BookingRequest.new(booking) }
  end
end
