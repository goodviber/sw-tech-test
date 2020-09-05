require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'byebug'

project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/lib/*') { |file| require file }

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Process Booking Requests'
  task :file_reader, [:booking_requests] do |t,args|

    theatre = Theatre.new
    booking_requests = []


    f = FileReader.new(args[:booking_requests])
    f.read_the_file do |r|
     booking_requests << BookingRequest.new(r[0], r[1], r[2], r[3], r[4])
    end

     # byebug
      BookingRequestRule.valid_booking?(booking_requests, theatre).apply

  end