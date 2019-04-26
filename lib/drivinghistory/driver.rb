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
  end
end