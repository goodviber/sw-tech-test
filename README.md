# Tech Test

A cinema has a theatre of 100 rows, each with 50 seats. Customers request particular seats when making a booking. Bookings are processed on a first-come, first-served basis. A booking is accepted as long as it is for five or fewer seats, all seats are adjacent and on the same row, all requested seats are available, and accepting the booking would not leave a single-seat gap (since the cinema believes nobody would book such a seat, and so loses the cinema money).



Write a system to process a text file of bookings (booking_requests) and determine the number of bookings which are rejected. To test your system, a smaller sample file (sample_booking_requests) is supplied; processing this file should yield 10 rejected requests.



The text file of bookings contains one booking per line, where a booking is of the following form:

(id, index of first seat row:index of first seat within row, index of last seat row:index of last seat within row),

Rows and seats are both 0-indexed. Note the trailing comma is absent on the final line.

### Built in ruby 2.7.1

Clone and run `bundle install`, then run `bundle exec rspec` to receive test output. Uses `bookings/sample_booking_requests` file for FileReader, the path is set in booking_manager_spec.rb, at line 16.

The rejections are:

[#<BookingRequest:0x00007fbc59a1f7d0 @id=63, @start_row=53, @first_seat=49, @end_row=53, @last_seat=51, @seats={:row=>53, :seat_range=>49..51}>, #<BookingRequest:0x00007fbc59a1d2f0 @id=113, @start_row=40, @first_seat=49, @end_row=40, @last_seat=51, @seats={:row=>40, :seat_range=>49..51}>, #<BookingRequest:0x00007fbc59a1d1b0 @id=115, @start_row=29, @first_seat=10, @end_row=29, @last_seat=11, @seats={:row=>29, :seat_range=>10..11}>, #<BookingRequest:0x00007fbc59a1c878 @id=130, @start_row=15, @first_seat=35, @end_row=15, @last_seat=45, @seats={:row=>15, :seat_range=>35..45}>, #<BookingRequest:0x00007fbc59a3ffa8 @id=229, @start_row=32, @first_seat=35, @end_row=33, @last_seat=37, @seats={:row=>32, :seat_range=>35..37}>, #<BookingRequest:0x00007fbc59a3e1a8 @id=280, @start_row=49, @first_seat=3, @end_row=49, @last_seat=4, @seats={:row=>49, :seat_range=>3..4}>, #<BookingRequest:0x00007fbc59a3e040 @id=283, @start_row=31, @first_seat=14, @end_row=31, @last_seat=24, @seats={:row=>31, :seat_range=>14..24}>, #<BookingRequest:0x00007fbc59a3d190 @id=308, @start_row=3, @first_seat=9, @end_row=3, @last_seat=10, @seats={:row=>3, :seat_range=>9..10}>, #<BookingRequest:0x00007fbc592126a0 @id=474, @start_row=56, @first_seat=29, @end_row=57, @last_seat=31, @seats={:row=>56, :seat_range=>29..31}>, #<BookingRequest:0x00007fbc59211cc8 @id=492, @start_row=19, @first_seat=17, @end_row=19, @last_seat=17, @seats={:row=>19, :seat_range=>17..17}>]
