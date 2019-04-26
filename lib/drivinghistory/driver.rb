require_relative 'trip'

module DrivingHistory
  class Driver
    attr_reader(
      :name,
      :trips,
      :total_miles_driven,
      :total_hours_driven
    )

    def initialize driver_name
      @name = driver_name
      @trips = []
      @total_miles_driven = 0.0
      @total_hours_driven = 0.0
    end

    def add_trip start, stop, miles
      new_trip = DrivingHistory::Trip.new(start, stop, miles)
      
      if new_trip.avg_mph < 5 then
        STDERR.puts "#{name}'s Trip that took place between #{start} and #{stop} was not recorded as the avg mph was less than 5mph."
      elsif new_trip.avg_mph > 100 then
        STDERR.puts "#{name}'s Trip that took place between #{start} and #{stop} was not recorded as the avg mph was greater than 100mph."
      else
        @total_miles_driven += new_trip.miles
        @total_hours_driven += new_trip.hours
        @trips.push new_trip
      end
    end

    def avg_mph
      @trips.size > 0 ? @total_miles_driven / @total_hours_driven : 0
    end
  end
end