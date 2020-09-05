require 'byebug'

class FileReader
  def initialize(booking_requests)
    @booking_requests = booking_requests
  end

  def read_the_file
    File.foreach(@booking_requests) do |line|
      line_array = line.split(/\((\d+),(\d+):(\d+),(\d+):(\d+)\),?/).slice(1..-1).map(&:to_i)
      yield(line_array)
    end
  end
end